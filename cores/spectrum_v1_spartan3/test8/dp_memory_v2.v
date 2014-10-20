`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:11 02/13/2014 
// Design Name: 
// Module Name:    dp_memory_v2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module dp_memory_v2 (
    input wire clk,  // 20MHz
    input wire [18:0] a1,
    output wire [7:0] dout1,
    input wire rd1_n,
    input wire [18:0] a2,
    input wire [7:0] din2,
    output wire [7:0] dout2,
    input wire rd2_n,
    input wire wr2_n,
    
    output reg [18:0] a,
    inout wire [7:0] d,
    output reg we_n
    );

   parameter
      IDLE = 0,
      READULA1 = 1,
      ESPERAULA = 2,
      ACCESOCPU1 = 3,
      ESPERATOTAL = 4,
      ACCESOCPU2 = 5,
      ESPERACPU = 6,
      READULA2 = 7;

   // Variables combinacionales
   reg [7:0] dinput_to_sram;
   reg write_to_dout1,write_to_dout2;
   reg [2:0] proximo;
   
   // Registros
   reg [2:0] estado = IDLE;
   reg [7:0] doutput1;
   reg [7:0] doutput2;
   
   assign dout1 = doutput1;
   assign dout2 = doutput2;
   assign d = dinput_to_sram;
   always @(posedge clk) begin
      estado <= proximo;
      if (write_to_dout1)
         doutput1 <= d;
      if (write_to_dout2)
         doutput2 <= d;
   end
      
/*

1:

Si hay peticion de R de la ULA
   Atenderla(ULA1)
   Mientras la peticion siga activa
      Si hay petición de R/W de CPU
         Atenderla(CPU1)
         Mientras todas las peticiones sigan activas
         Finmientras
         Ir a 1:
      Finsi
   Finmientras
   Ir a 1:
Si no, si hay peticion R/W de la CPU
  Atenderla(CPU2)
  Mientras la peticion siga activa
    Si hay peticion de R de la ULA
      Atenderla(ULA2)
      Mientras todas las peticion sigan activas
      Finmientras
      Ir a 1:
    Finsi
  Finmientra
  Ir a 1:
Finsi
Ir a 1:      

*/

   always @* begin
      a = a1;
      we_n = 1'b1;
      proximo = IDLE;
      dinput_to_sram = 8'hZZ;
      write_to_dout1 = 1'b0;
      write_to_dout2 = 1'b0;
      case (estado)
         IDLE       : begin
                        if (!rd1_n) begin
                          a = a1;
                          proximo = READULA1;
                        end
                        else if (!rd2_n || !wr2_n) begin
                          a = a2;
                          if (!wr2_n) begin
                            dinput_to_sram = din2;
                            we_n = 1'b0;
                          end
                          proximo = ACCESOCPU2;
                        end
                      end
                      
         READULA1   : begin
                        a = a1;
                        write_to_dout1 = 1'b1;
                        proximo = ESPERAULA;
                      end
                      
         ESPERAULA  : begin
                        if (rd1_n && rd2_n && wr2_n) begin
                          proximo = IDLE;
                        end
                        else if (rd1_n && (!rd2_n || !wr2_n)) begin
                          a = a2;
                          if (!wr2_n) begin
                            dinput_to_sram = din2;
                            we_n = 1'b0;
                          end
                          proximo = ACCESOCPU1;
                        end
                        else begin
                          proximo = ESPERAULA;
                        end
                      end
                      
         ACCESOCPU1 : begin
                        a = a2;
                        if (!rd2_n) begin
                           write_to_dout2 = 1'b1;
                        end
                        else if (!wr2_n) begin
                           dinput_to_sram = din2;
                           we_n = 1'b0;
                        end
                        proximo = ESPERATOTAL;
                      end
                      
         ESPERATOTAL: begin
                        if (!rd1_n || !rd2_n || wr2_n) begin
                          proximo = ESPERATOTAL;
                        end
                      end

         ACCESOCPU2 : begin
                        a = a2;
                        if (!rd2_n) begin
                           write_to_dout2 = 1'b1;
                        end
                        else if (!wr2_n) begin
                           dinput_to_sram = din2;
                           we_n = 1'b0;
                        end
                        proximo = ESPERACPU;
                      end
                      
         ESPERACPU :  begin
                        if (rd1_n && rd2_n && wr2_n) begin
                          proximo = IDLE;
                        end
                        else if (!rd1_n) begin
                          a = a1;
                          proximo = READULA2;
                        end
                        else begin
                          proximo = ESPERACPU;
                        end
                      end

         READULA2   : begin
                        a = a1;
                        write_to_dout1 = 1'b1;
                        proximo = ESPERATOTAL;
                      end
      endcase
   end
endmodule
