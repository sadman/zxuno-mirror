<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="6.5.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="1" fill="3" visible="no" active="no"/>
<layer number="3" name="Route3" color="4" fill="3" visible="no" active="no"/>
<layer number="4" name="Route4" color="1" fill="4" visible="no" active="no"/>
<layer number="5" name="Route5" color="4" fill="4" visible="no" active="no"/>
<layer number="6" name="Route6" color="1" fill="8" visible="no" active="no"/>
<layer number="7" name="Route7" color="4" fill="8" visible="no" active="no"/>
<layer number="8" name="Route8" color="1" fill="2" visible="no" active="no"/>
<layer number="9" name="Route9" color="4" fill="2" visible="no" active="no"/>
<layer number="10" name="Route10" color="1" fill="7" visible="no" active="no"/>
<layer number="11" name="Route11" color="4" fill="7" visible="no" active="no"/>
<layer number="12" name="Route12" color="1" fill="5" visible="no" active="no"/>
<layer number="13" name="Route13" color="4" fill="5" visible="no" active="no"/>
<layer number="14" name="Route14" color="1" fill="6" visible="no" active="no"/>
<layer number="15" name="Route15" color="4" fill="6" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="250" name="Descript" color="7" fill="1" visible="yes" active="yes"/>
<layer number="251" name="SMDround" color="7" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="memory">
<description>&lt;b&gt;Generic Memories&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="PLCC32R">
<description>&lt;b&gt;PLASTIC LEADED CHIP CARRIER&lt;/b&gt;&lt;p&gt;
rectangle</description>
<wire x1="-5.61" y1="-6.93" x2="5.61" y2="-6.93" width="0.2032" layer="51"/>
<wire x1="5.61" y1="-6.93" x2="5.61" y2="6.93" width="0.2032" layer="51"/>
<wire x1="5.61" y1="6.93" x2="-4.77" y2="6.93" width="0.2032" layer="51"/>
<wire x1="-4.77" y1="6.93" x2="-5.61" y2="6.09" width="0.2032" layer="51"/>
<wire x1="-5.61" y1="6.09" x2="-5.61" y2="-6.93" width="0.2032" layer="51"/>
<circle x="0" y="5.4" radius="0.3" width="0.6096" layer="51"/>
<smd name="1" x="0" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="2" x="-1.27" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="3" x="-2.54" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="4" x="-3.81" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="6" x="-5.7" y="3.81" dx="2.2" dy="0.6" layer="1"/>
<smd name="7" x="-5.7" y="2.54" dx="2.2" dy="0.6" layer="1"/>
<smd name="8" x="-5.7" y="1.27" dx="2.2" dy="0.6" layer="1"/>
<smd name="9" x="-5.7" y="0" dx="2.2" dy="0.6" layer="1"/>
<smd name="10" x="-5.7" y="-1.27" dx="2.2" dy="0.6" layer="1"/>
<smd name="11" x="-5.7" y="-2.54" dx="2.2" dy="0.6" layer="1"/>
<smd name="12" x="-5.7" y="-3.81" dx="2.2" dy="0.6" layer="1"/>
<smd name="5" x="-5.7" y="5.08" dx="2.2" dy="0.6" layer="1"/>
<smd name="13" x="-5.7" y="-5.08" dx="2.2" dy="0.6" layer="1"/>
<smd name="14" x="-3.81" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="15" x="-2.54" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="16" x="-1.27" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="17" x="0" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="18" x="1.27" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="19" x="2.54" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="20" x="3.81" y="-6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="21" x="5.7" y="-5.08" dx="2.2" dy="0.6" layer="1"/>
<smd name="22" x="5.7" y="-3.81" dx="2.2" dy="0.6" layer="1"/>
<smd name="23" x="5.7" y="-2.54" dx="2.2" dy="0.6" layer="1"/>
<smd name="24" x="5.7" y="-1.27" dx="2.2" dy="0.6" layer="1"/>
<smd name="25" x="5.7" y="0" dx="2.2" dy="0.6" layer="1"/>
<smd name="26" x="5.7" y="1.27" dx="2.2" dy="0.6" layer="1"/>
<smd name="27" x="5.7" y="2.54" dx="2.2" dy="0.6" layer="1"/>
<smd name="28" x="5.7" y="3.81" dx="2.2" dy="0.6" layer="1"/>
<smd name="29" x="5.7" y="5.08" dx="2.2" dy="0.6" layer="1"/>
<smd name="30" x="3.81" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="31" x="2.54" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<smd name="32" x="1.27" y="6.9" dx="0.6" dy="2.2" layer="1"/>
<text x="-2.825" y="5.2751" size="1.778" layer="25" rot="R270">&gt;NAME</text>
<text x="0.6949" y="5.2451" size="1.778" layer="27" rot="R270">&gt;VALUE</text>
<rectangle x1="-0.2601" y1="6.9499" x2="0.27" y2="7.5301" layer="51"/>
<rectangle x1="-1.5301" y1="6.9499" x2="-1" y2="7.5301" layer="51"/>
<rectangle x1="-2.8001" y1="6.9499" x2="-2.27" y2="7.5301" layer="51"/>
<rectangle x1="-4.0701" y1="6.9499" x2="-3.54" y2="7.5301" layer="51"/>
<rectangle x1="-6.3299" y1="4.8199" x2="-5.7501" y2="5.35" layer="51"/>
<rectangle x1="-6.3299" y1="3.5499" x2="-5.7501" y2="4.08" layer="51"/>
<rectangle x1="-6.3299" y1="2.2799" x2="-5.7501" y2="2.81" layer="51"/>
<rectangle x1="-6.3299" y1="1.0099" x2="-5.7501" y2="1.54" layer="51"/>
<rectangle x1="-6.3299" y1="-0.2601" x2="-5.7501" y2="0.27" layer="51"/>
<rectangle x1="-6.3299" y1="-1.5301" x2="-5.7501" y2="-1" layer="51"/>
<rectangle x1="-6.3299" y1="-2.8001" x2="-5.7501" y2="-2.27" layer="51"/>
<rectangle x1="-6.3299" y1="-4.0701" x2="-5.7501" y2="-3.54" layer="51"/>
<rectangle x1="-6.3299" y1="-5.3401" x2="-5.7501" y2="-4.81" layer="51"/>
<rectangle x1="-4.08" y1="-7.5301" x2="-3.5499" y2="-6.9499" layer="51"/>
<rectangle x1="-2.81" y1="-7.5301" x2="-2.2799" y2="-6.9499" layer="51"/>
<rectangle x1="-1.54" y1="-7.5301" x2="-1.0099" y2="-6.9499" layer="51"/>
<rectangle x1="-0.27" y1="-7.5301" x2="0.2601" y2="-6.9499" layer="51"/>
<rectangle x1="1" y1="-7.5301" x2="1.5301" y2="-6.9499" layer="51"/>
<rectangle x1="2.27" y1="-7.5301" x2="2.8001" y2="-6.9499" layer="51"/>
<rectangle x1="3.54" y1="-7.5301" x2="4.0701" y2="-6.9499" layer="51"/>
<rectangle x1="5.7501" y1="-5.35" x2="6.3299" y2="-4.8199" layer="51"/>
<rectangle x1="5.7501" y1="-4.08" x2="6.3299" y2="-3.5499" layer="51"/>
<rectangle x1="5.7501" y1="-2.81" x2="6.3299" y2="-2.2799" layer="51"/>
<rectangle x1="5.7501" y1="-1.54" x2="6.3299" y2="-1.0099" layer="51"/>
<rectangle x1="5.7501" y1="-0.27" x2="6.3299" y2="0.2601" layer="51"/>
<rectangle x1="5.7501" y1="1" x2="6.3299" y2="1.5301" layer="51"/>
<rectangle x1="5.7501" y1="2.27" x2="6.3299" y2="2.8001" layer="51"/>
<rectangle x1="5.7501" y1="3.54" x2="6.3299" y2="4.0701" layer="51"/>
<rectangle x1="5.7501" y1="4.81" x2="6.3299" y2="5.3401" layer="51"/>
<rectangle x1="3.5499" y1="6.9499" x2="4.08" y2="7.5301" layer="51"/>
<rectangle x1="2.2799" y1="6.9499" x2="2.81" y2="7.5301" layer="51"/>
<rectangle x1="1.0099" y1="6.9499" x2="1.54" y2="7.5301" layer="51"/>
</package>
<package name="TSOP32">
<description>&lt;b&gt;Thin Small Outline Package&lt;/b&gt;</description>
<wire x1="-9" y1="3.9" x2="9" y2="3.9" width="0.254" layer="21"/>
<wire x1="9" y1="3.9" x2="9" y2="-3.9" width="0.254" layer="21"/>
<wire x1="9" y1="-3.9" x2="-9" y2="-3.9" width="0.254" layer="21"/>
<wire x1="-9" y1="-3.9" x2="-9" y2="3.9" width="0.254" layer="21"/>
<circle x="-8.21" y="3" radius="0.4" width="0.254" layer="21"/>
<smd name="1" x="-9.85" y="3.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="2" x="-9.85" y="3.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="3" x="-9.85" y="2.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="4" x="-9.85" y="2.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="5" x="-9.85" y="1.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="6" x="-9.85" y="1.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="7" x="-9.85" y="0.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="8" x="-9.85" y="0.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="9" x="-9.85" y="-0.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="10" x="-9.85" y="-0.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="11" x="-9.85" y="-1.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="12" x="-9.85" y="-1.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="13" x="-9.85" y="-2.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="14" x="-9.85" y="-2.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="15" x="-9.85" y="-3.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="16" x="-9.85" y="-3.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="17" x="9.85" y="-3.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="18" x="9.85" y="-3.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="19" x="9.85" y="-2.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="20" x="9.85" y="-2.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="21" x="9.85" y="-1.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="22" x="9.85" y="-1.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="23" x="9.85" y="-0.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="24" x="9.85" y="-0.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="25" x="9.85" y="0.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="26" x="9.85" y="0.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="27" x="9.85" y="1.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="28" x="9.85" y="1.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="29" x="9.85" y="2.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="30" x="9.85" y="2.75" dx="1.2" dy="0.36" layer="1"/>
<smd name="31" x="9.85" y="3.25" dx="1.2" dy="0.36" layer="1"/>
<smd name="32" x="9.85" y="3.75" dx="1.2" dy="0.36" layer="1"/>
<text x="-9.144" y="4.318" size="1.27" layer="25">&gt;NAME</text>
<text x="-8.128" y="-0.508" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-10.1096" y1="3.5976" x2="-9.0428" y2="3.9024" layer="51"/>
<rectangle x1="-10.1096" y1="3.0976" x2="-9.0428" y2="3.4024" layer="51"/>
<rectangle x1="-10.1096" y1="2.5976" x2="-9.0428" y2="2.9024" layer="51"/>
<rectangle x1="-10.1096" y1="2.0976" x2="-9.0428" y2="2.4024" layer="51"/>
<rectangle x1="-10.1096" y1="1.5976" x2="-9.0428" y2="1.9024" layer="51"/>
<rectangle x1="-10.1096" y1="1.0976" x2="-9.0428" y2="1.4024" layer="51"/>
<rectangle x1="-10.1096" y1="0.5976" x2="-9.0428" y2="0.9024" layer="51"/>
<rectangle x1="-10.1096" y1="0.0976" x2="-9.0428" y2="0.4024" layer="51"/>
<rectangle x1="-10.1096" y1="-0.4024" x2="-9.0428" y2="-0.0976" layer="51"/>
<rectangle x1="-10.1096" y1="-0.9024" x2="-9.0428" y2="-0.5976" layer="51"/>
<rectangle x1="-10.1096" y1="-1.4024" x2="-9.0428" y2="-1.0976" layer="51"/>
<rectangle x1="-10.1096" y1="-1.9024" x2="-9.0428" y2="-1.5976" layer="51"/>
<rectangle x1="-10.1096" y1="-2.4024" x2="-9.0428" y2="-2.0976" layer="51"/>
<rectangle x1="-10.1096" y1="-2.9024" x2="-9.0428" y2="-2.5976" layer="51"/>
<rectangle x1="-10.1096" y1="-3.4024" x2="-9.0428" y2="-3.0976" layer="51"/>
<rectangle x1="-10.1096" y1="-3.9024" x2="-9.0428" y2="-3.5976" layer="51"/>
<rectangle x1="9.0428" y1="-3.9024" x2="10.1096" y2="-3.5976" layer="51"/>
<rectangle x1="9.0428" y1="-3.4024" x2="10.1096" y2="-3.0976" layer="51"/>
<rectangle x1="9.0428" y1="-2.9024" x2="10.1096" y2="-2.5976" layer="51"/>
<rectangle x1="9.0428" y1="-2.4024" x2="10.1096" y2="-2.0976" layer="51"/>
<rectangle x1="9.0428" y1="-1.9024" x2="10.1096" y2="-1.5976" layer="51"/>
<rectangle x1="9.0428" y1="-1.4024" x2="10.1096" y2="-1.0976" layer="51"/>
<rectangle x1="9.0428" y1="-0.9024" x2="10.1096" y2="-0.5976" layer="51"/>
<rectangle x1="9.0428" y1="-0.4024" x2="10.1096" y2="-0.0976" layer="51"/>
<rectangle x1="9.0428" y1="0.0976" x2="10.1096" y2="0.4024" layer="51"/>
<rectangle x1="9.0428" y1="0.5976" x2="10.1096" y2="0.9024" layer="51"/>
<rectangle x1="9.0428" y1="1.0976" x2="10.1096" y2="1.4024" layer="51"/>
<rectangle x1="9.0428" y1="1.5976" x2="10.1096" y2="1.9024" layer="51"/>
<rectangle x1="9.0428" y1="2.0976" x2="10.1096" y2="2.4024" layer="51"/>
<rectangle x1="9.0428" y1="2.5976" x2="10.1096" y2="2.9024" layer="51"/>
<rectangle x1="9.0428" y1="3.0976" x2="10.1096" y2="3.4024" layer="51"/>
<rectangle x1="9.0428" y1="3.5976" x2="10.1096" y2="3.9024" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="SST39VF040">
<wire x1="-7.62" y1="-30.48" x2="7.62" y2="-30.48" width="0.4064" layer="94"/>
<wire x1="7.62" y1="-30.48" x2="7.62" y2="30.48" width="0.4064" layer="94"/>
<wire x1="7.62" y1="30.48" x2="-7.62" y2="30.48" width="0.4064" layer="94"/>
<wire x1="-7.62" y1="30.48" x2="-7.62" y2="-30.48" width="0.4064" layer="94"/>
<text x="-7.62" y="31.115" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-33.02" size="1.778" layer="96">&gt;VALUE</text>
<pin name="A7" x="-10.16" y="10.16" length="short" direction="in"/>
<pin name="A6" x="-10.16" y="12.7" length="short" direction="in"/>
<pin name="A5" x="-10.16" y="15.24" length="short" direction="in"/>
<pin name="A4" x="-10.16" y="17.78" length="short" direction="in"/>
<pin name="A3" x="-10.16" y="20.32" length="short" direction="in"/>
<pin name="A2" x="-10.16" y="22.86" length="short" direction="in"/>
<pin name="A1" x="-10.16" y="25.4" length="short" direction="in"/>
<pin name="A0" x="-10.16" y="27.94" length="short" direction="in"/>
<pin name="D0" x="10.16" y="27.94" length="short" rot="R180"/>
<pin name="D1" x="10.16" y="25.4" length="short" rot="R180"/>
<pin name="D2" x="10.16" y="22.86" length="short" rot="R180"/>
<pin name="D3" x="10.16" y="20.32" length="short" rot="R180"/>
<pin name="D4" x="10.16" y="17.78" length="short" rot="R180"/>
<pin name="D5" x="10.16" y="15.24" length="short" rot="R180"/>
<pin name="D6" x="10.16" y="12.7" length="short" rot="R180"/>
<pin name="D7" x="10.16" y="10.16" length="short" rot="R180"/>
<pin name="!CE" x="-10.16" y="-22.86" length="short" direction="in"/>
<pin name="A10" x="-10.16" y="2.54" length="short" direction="in"/>
<pin name="!OE" x="-10.16" y="-25.4" length="short" direction="in"/>
<pin name="!WE" x="-10.16" y="-27.94" length="short" direction="in"/>
<pin name="A9" x="-10.16" y="5.08" length="short" direction="in"/>
<pin name="A8" x="-10.16" y="7.62" length="short" direction="in"/>
<pin name="A11" x="-10.16" y="0" length="short" direction="in"/>
<pin name="A12" x="-10.16" y="-2.54" length="short" direction="in"/>
<pin name="A13" x="-10.16" y="-5.08" length="short" direction="in"/>
<pin name="A14" x="-10.16" y="-7.62" length="short" direction="in"/>
<pin name="A15" x="-10.16" y="-10.16" length="short" direction="in"/>
<pin name="A16" x="-10.16" y="-12.7" length="short" direction="in"/>
<pin name="A17" x="-10.16" y="-15.24" length="short" direction="in"/>
<pin name="A18" x="-10.16" y="-17.78" length="short" direction="in"/>
</symbol>
<symbol name="PWRN">
<text x="-0.635" y="-0.635" size="1.778" layer="95">&gt;NAME</text>
<text x="1.905" y="-5.588" size="1.27" layer="95" rot="R90">GND</text>
<text x="1.905" y="2.413" size="1.27" layer="95" rot="R90">VCC</text>
<pin name="GND" x="0" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="VCC" x="0" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="SST39VF040" prefix="IC">
<description>&lt;b&gt;4 Mbit x8 Multi-Purpose Flash&lt;/b&gt;&lt;p&gt;
Source: http://www.sst.com/dotAsset/40782.pdf</description>
<gates>
<gate name="G$1" symbol="SST39VF040" x="0" y="0"/>
<gate name="P" symbol="PWRN" x="15.24" y="-7.62" addlevel="request"/>
</gates>
<devices>
<device name="N" package="PLCC32R">
<connects>
<connect gate="G$1" pin="!CE" pad="22"/>
<connect gate="G$1" pin="!OE" pad="24"/>
<connect gate="G$1" pin="!WE" pad="31"/>
<connect gate="G$1" pin="A0" pad="12"/>
<connect gate="G$1" pin="A1" pad="11"/>
<connect gate="G$1" pin="A10" pad="23"/>
<connect gate="G$1" pin="A11" pad="25"/>
<connect gate="G$1" pin="A12" pad="4"/>
<connect gate="G$1" pin="A13" pad="28"/>
<connect gate="G$1" pin="A14" pad="29"/>
<connect gate="G$1" pin="A15" pad="3"/>
<connect gate="G$1" pin="A16" pad="2"/>
<connect gate="G$1" pin="A17" pad="30"/>
<connect gate="G$1" pin="A18" pad="1"/>
<connect gate="G$1" pin="A2" pad="10"/>
<connect gate="G$1" pin="A3" pad="9"/>
<connect gate="G$1" pin="A4" pad="8"/>
<connect gate="G$1" pin="A5" pad="7"/>
<connect gate="G$1" pin="A6" pad="6"/>
<connect gate="G$1" pin="A7" pad="5"/>
<connect gate="G$1" pin="A8" pad="27"/>
<connect gate="G$1" pin="A9" pad="26"/>
<connect gate="G$1" pin="D0" pad="13"/>
<connect gate="G$1" pin="D1" pad="14"/>
<connect gate="G$1" pin="D2" pad="15"/>
<connect gate="G$1" pin="D3" pad="17"/>
<connect gate="G$1" pin="D4" pad="18"/>
<connect gate="G$1" pin="D5" pad="19"/>
<connect gate="G$1" pin="D6" pad="20"/>
<connect gate="G$1" pin="D7" pad="21"/>
<connect gate="P" pin="GND" pad="16"/>
<connect gate="P" pin="VCC" pad="32"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="W" package="TSOP32">
<connects>
<connect gate="G$1" pin="!CE" pad="30"/>
<connect gate="G$1" pin="!OE" pad="32"/>
<connect gate="G$1" pin="!WE" pad="7"/>
<connect gate="G$1" pin="A0" pad="20"/>
<connect gate="G$1" pin="A1" pad="19"/>
<connect gate="G$1" pin="A10" pad="31"/>
<connect gate="G$1" pin="A11" pad="1"/>
<connect gate="G$1" pin="A12" pad="12"/>
<connect gate="G$1" pin="A13" pad="4"/>
<connect gate="G$1" pin="A14" pad="5"/>
<connect gate="G$1" pin="A15" pad="11"/>
<connect gate="G$1" pin="A16" pad="10"/>
<connect gate="G$1" pin="A17" pad="6"/>
<connect gate="G$1" pin="A18" pad="9"/>
<connect gate="G$1" pin="A2" pad="18"/>
<connect gate="G$1" pin="A3" pad="17"/>
<connect gate="G$1" pin="A4" pad="16"/>
<connect gate="G$1" pin="A5" pad="15"/>
<connect gate="G$1" pin="A6" pad="14"/>
<connect gate="G$1" pin="A7" pad="13"/>
<connect gate="G$1" pin="A8" pad="3"/>
<connect gate="G$1" pin="A9" pad="2"/>
<connect gate="G$1" pin="D0" pad="21"/>
<connect gate="G$1" pin="D1" pad="22"/>
<connect gate="G$1" pin="D2" pad="23"/>
<connect gate="G$1" pin="D3" pad="25"/>
<connect gate="G$1" pin="D4" pad="26"/>
<connect gate="G$1" pin="D5" pad="27"/>
<connect gate="G$1" pin="D6" pad="28"/>
<connect gate="G$1" pin="D7" pad="29"/>
<connect gate="P" pin="GND" pad="24"/>
<connect gate="P" pin="VCC" pad="8"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="special">
<description>&lt;b&gt;Special Devices&lt;/b&gt;&lt;p&gt;
7-segment displays, switches, heatsinks, crystals, transformers, etc.&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="SW-C16">
<description>&lt;B&gt;SWITCH&lt;/B&gt;&lt;p&gt;
16-step rotary</description>
<wire x1="-5.08" y1="-5.08" x2="-3.81" y2="-5.08" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-5.08" x2="5.08" y2="5.08" width="0.1524" layer="21"/>
<wire x1="5.08" y1="5.08" x2="-5.08" y2="5.08" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-5.08" x2="-5.08" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="1.8288" y1="0" x2="2.2098" y2="0" width="0.1016" layer="21"/>
<wire x1="0" y1="1.8034" x2="0" y2="2.1844" width="0.1016" layer="21"/>
<wire x1="-2.1844" y1="0" x2="-1.8034" y2="0" width="0.0508" layer="21"/>
<wire x1="1.2954" y1="-1.2954" x2="1.5494" y2="-1.5494" width="0.0508" layer="21"/>
<wire x1="-1.27" y1="1.27" x2="-1.524" y2="1.524" width="0.1016" layer="21"/>
<wire x1="1.2954" y1="1.2954" x2="1.5494" y2="1.5494" width="0.0508" layer="21"/>
<wire x1="-1.2954" y1="-1.27" x2="-1.5494" y2="-1.524" width="0.0508" layer="21"/>
<wire x1="0.762" y1="1.651" x2="0.9144" y2="1.9812" width="0.0508" layer="21"/>
<wire x1="1.651" y1="0.6604" x2="2.0574" y2="0.8382" width="0.0508" layer="21"/>
<wire x1="1.6764" y1="-0.7112" x2="2.0066" y2="-0.8382" width="0.0508" layer="21"/>
<wire x1="0.7112" y1="-1.6764" x2="0.8636" y2="-2.032" width="0.0508" layer="21"/>
<wire x1="-0.762" y1="-1.651" x2="-0.9144" y2="-1.9812" width="0.0508" layer="21"/>
<wire x1="-1.651" y1="-0.7112" x2="-2.032" y2="-0.8636" width="0.0508" layer="21"/>
<wire x1="-1.651" y1="0.7366" x2="-2.032" y2="0.889" width="0.0508" layer="21"/>
<wire x1="-0.6604" y1="1.7018" x2="-0.8128" y2="2.0828" width="0.0508" layer="21"/>
<wire x1="-0.508" y1="-1.0922" x2="0" y2="-1.6002" width="0.254" layer="21"/>
<wire x1="0" y1="-1.6002" x2="0.508" y2="-1.0922" width="0.254" layer="21"/>
<wire x1="0.508" y1="-1.0922" x2="-0.508" y2="-1.0922" width="0.254" layer="21"/>
<wire x1="0" y1="-1.8288" x2="0" y2="-2.2098" width="0.0508" layer="21"/>
<wire x1="-0.254" y1="-1.2192" x2="0.254" y2="-1.2192" width="0.254" layer="21"/>
<wire x1="0" y1="-1.4732" x2="0" y2="-1.3462" width="0.254" layer="21"/>
<wire x1="-5.08" y1="-3.81" x2="-3.81" y2="-5.08" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-3.81" x2="-5.08" y2="5.08" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="-5.08" x2="5.08" y2="-5.08" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="1.143" x2="-3.048" y2="1.7018" width="0.1016" layer="21"/>
<wire x1="-3.302" y1="1.143" x2="-2.8956" y2="0.9398" width="0.1016" layer="21"/>
<wire x1="-2.8956" y1="0.9398" x2="-2.921" y2="1.1684" width="0.1016" layer="21"/>
<wire x1="-2.921" y1="1.1684" x2="-2.8194" y2="1.397" width="0.1016" layer="21"/>
<wire x1="-2.3622" y1="1.3462" x2="-2.286" y2="1.143" width="0.1016" layer="21"/>
<wire x1="-2.286" y1="1.143" x2="-2.413" y2="0.889" width="0.1016" layer="21"/>
<wire x1="-2.413" y1="0.889" x2="-2.6162" y2="0.8128" width="0.1016" layer="21"/>
<wire x1="-2.8194" y1="1.397" x2="-2.6162" y2="1.4732" width="0.1016" layer="21"/>
<wire x1="-2.6162" y1="1.4732" x2="-2.3622" y2="1.3462" width="0.1016" layer="21"/>
<wire x1="-1.8796" y1="1.7272" x2="-1.6256" y2="1.9812" width="0.1016" layer="21"/>
<wire x1="-1.6256" y1="1.9812" x2="-1.6256" y2="2.2352" width="0.1016" layer="21"/>
<wire x1="-1.6256" y1="2.2352" x2="-1.7272" y2="2.3368" width="0.1016" layer="21"/>
<wire x1="-1.7272" y1="2.3368" x2="-1.9812" y2="2.3368" width="0.1016" layer="21"/>
<wire x1="-1.9812" y1="2.3368" x2="-2.3368" y2="1.9304" width="0.1016" layer="21"/>
<wire x1="-1.8796" y1="1.7272" x2="-2.1336" y2="1.7272" width="0.1016" layer="21"/>
<wire x1="-2.1336" y1="1.7272" x2="-2.3368" y2="1.9304" width="0.1016" layer="21"/>
<wire x1="-2.3368" y1="1.9304" x2="-2.4384" y2="2.3876" width="0.1016" layer="21"/>
<wire x1="-2.4384" y1="2.3876" x2="-2.2352" y2="2.7432" width="0.1016" layer="21"/>
<wire x1="-1.5748" y1="3.0988" x2="-1.016" y2="3.3528" width="0.1016" layer="21"/>
<wire x1="-1.1684" y1="2.4384" x2="-1.1176" y2="2.286" width="0.1016" layer="21"/>
<wire x1="-1.016" y1="3.3528" x2="-0.9652" y2="3.2004" width="0.1016" layer="21"/>
<wire x1="-0.9652" y1="3.2004" x2="-1.1684" y2="2.4384" width="0.1016" layer="21"/>
<wire x1="1.6256" y1="3.1496" x2="1.3208" y2="3.302" width="0.1016" layer="51"/>
<wire x1="1.3208" y1="3.302" x2="1.0668" y2="3.2512" width="0.1016" layer="51"/>
<wire x1="1.0668" y1="3.2512" x2="0.9652" y2="3.048" width="0.1016" layer="51"/>
<wire x1="0.9652" y1="3.048" x2="1.0668" y2="2.794" width="0.1016" layer="51"/>
<wire x1="1.0668" y1="2.794" x2="1.524" y2="2.5908" width="0.1016" layer="21"/>
<wire x1="1.6256" y1="3.1496" x2="1.6764" y2="2.8448" width="0.1016" layer="51"/>
<wire x1="1.6764" y1="2.8448" x2="1.524" y2="2.5908" width="0.1016" layer="21"/>
<wire x1="1.524" y1="2.5908" x2="1.2192" y2="2.3876" width="0.1016" layer="21"/>
<wire x1="1.2192" y1="2.3876" x2="0.762" y2="2.4384" width="0.1016" layer="21"/>
<wire x1="1.524" y1="2.032" x2="1.8288" y2="2.3368" width="0.1016" layer="21"/>
<wire x1="2.032" y1="2.54" x2="2.4892" y2="2.4892" width="0.1016" layer="21"/>
<wire x1="2.4892" y1="2.4892" x2="2.54" y2="2.032" width="0.1016" layer="21"/>
<wire x1="2.54" y1="2.032" x2="2.3368" y2="1.8288" width="0.1016" layer="21"/>
<wire x1="1.8288" y1="2.3368" x2="2.3368" y2="1.8288" width="0.1016" layer="21"/>
<wire x1="1.8288" y1="2.3368" x2="2.032" y2="2.54" width="0.1016" layer="21"/>
<wire x1="2.3368" y1="1.8288" x2="2.032" y2="1.524" width="0.1016" layer="21"/>
<wire x1="2.286" y1="1.1684" x2="2.7432" y2="1.3716" width="0.1016" layer="21"/>
<wire x1="3.1496" y1="1.5748" x2="3.3528" y2="1.1176" width="0.1016" layer="21"/>
<wire x1="3.3528" y1="1.1176" x2="3.302" y2="0.9652" width="0.1016" layer="21"/>
<wire x1="3.302" y1="0.9652" x2="3.0988" y2="0.8636" width="0.1016" layer="21"/>
<wire x1="3.0988" y1="0.8636" x2="2.9464" y2="0.9144" width="0.1016" layer="21"/>
<wire x1="2.9464" y1="0.9144" x2="2.7432" y2="1.3716" width="0.1016" layer="21"/>
<wire x1="2.9464" y1="0.9144" x2="2.8448" y2="0.7112" width="0.1016" layer="21"/>
<wire x1="2.8448" y1="0.7112" x2="2.667" y2="0.635" width="0.1016" layer="21"/>
<wire x1="2.667" y1="0.635" x2="2.4892" y2="0.6604" width="0.1016" layer="21"/>
<wire x1="2.4892" y1="0.6604" x2="2.286" y2="1.1684" width="0.1016" layer="21"/>
<wire x1="2.7432" y1="1.3716" x2="3.1496" y2="1.5748" width="0.1016" layer="21"/>
<wire x1="2.7432" y1="0.3048" x2="3.3528" y2="0.3048" width="0.1016" layer="21"/>
<wire x1="3.3528" y1="0.3048" x2="3.5052" y2="0.1524" width="0.1016" layer="21"/>
<wire x1="3.5052" y1="0.1524" x2="3.5052" y2="-0.1524" width="0.1016" layer="21"/>
<wire x1="3.5052" y1="-0.1524" x2="3.3528" y2="-0.3048" width="0.1016" layer="21"/>
<wire x1="2.7432" y1="0.3048" x2="2.54" y2="0.1524" width="0.1016" layer="21"/>
<wire x1="2.54" y1="0.1524" x2="2.54" y2="-0.1524" width="0.1016" layer="21"/>
<wire x1="2.54" y1="-0.1524" x2="2.7432" y2="-0.3048" width="0.1016" layer="21"/>
<wire x1="2.4384" y1="-0.762" x2="2.2606" y2="-1.1684" width="0.1016" layer="21"/>
<wire x1="2.2606" y1="-1.1684" x2="2.3368" y2="-1.3716" width="0.1016" layer="21"/>
<wire x1="2.3368" y1="-1.3716" x2="2.9718" y2="-1.6764" width="0.1016" layer="21"/>
<wire x1="2.9718" y1="-1.6764" x2="3.1496" y2="-1.6002" width="0.1016" layer="21"/>
<wire x1="3.1496" y1="-1.6002" x2="3.3528" y2="-1.1684" width="0.1016" layer="21"/>
<wire x1="3.3528" y1="-1.1684" x2="2.4384" y2="-0.762" width="0.1016" layer="21"/>
<wire x1="2.0066" y1="-1.5748" x2="1.6002" y2="-1.9558" width="0.1016" layer="21"/>
<wire x1="2.0066" y1="-1.5748" x2="2.3622" y2="-1.9304" width="0.1016" layer="21"/>
<wire x1="2.7178" y1="-2.286" x2="2.286" y2="-2.7178" width="0.1016" layer="21"/>
<wire x1="2.3622" y1="-1.9304" x2="2.1336" y2="-2.159" width="0.1016" layer="21"/>
<wire x1="2.3622" y1="-1.9304" x2="2.7178" y2="-2.286" width="0.1016" layer="21"/>
<wire x1="1.1176" y1="-3.3274" x2="1.6002" y2="-3.0988" width="0.1016" layer="51"/>
<wire x1="1.6002" y1="-3.0988" x2="1.397" y2="-2.667" width="0.1016" layer="51"/>
<wire x1="1.397" y1="-2.667" x2="1.0414" y2="-2.8194" width="0.1016" layer="21"/>
<wire x1="1.397" y1="-2.667" x2="1.1938" y2="-2.2352" width="0.1016" layer="21"/>
<wire x1="-1.1938" y1="-2.2352" x2="-0.9144" y2="-2.3622" width="0.1016" layer="21"/>
<wire x1="-1.0668" y1="-2.3114" x2="-1.4478" y2="-3.1496" width="0.1016" layer="51"/>
<wire x1="-1.4478" y1="-3.1496" x2="-1.143" y2="-3.0988" width="0.1016" layer="51"/>
<wire x1="-2.032" y1="-1.5494" x2="-1.6256" y2="-1.9812" width="0.1016" layer="21"/>
<wire x1="-2.6416" y1="-2.286" x2="-2.3876" y2="-2.5654" width="0.1016" layer="21"/>
<wire x1="-2.3876" y1="-2.5654" x2="-2.1082" y2="-2.5654" width="0.1016" layer="21"/>
<wire x1="-2.6416" y1="-2.286" x2="-2.6416" y2="-2.0574" width="0.1016" layer="21"/>
<wire x1="-2.6416" y1="-2.0574" x2="-2.4892" y2="-1.9304" width="0.1016" layer="21"/>
<wire x1="-2.4892" y1="-1.9304" x2="-1.6256" y2="-1.9812" width="0.1016" layer="21"/>
<wire x1="-2.413" y1="-0.762" x2="-2.2352" y2="-1.1938" width="0.1016" layer="21"/>
<wire x1="-3.3274" y1="-1.143" x2="-3.1496" y2="-1.5748" width="0.1016" layer="21"/>
<wire x1="-2.8956" y1="-1.6256" x2="-3.1496" y2="-1.5748" width="0.1016" layer="21"/>
<wire x1="-2.3368" y1="-1.3716" x2="-2.2352" y2="-1.1938" width="0.1016" layer="21"/>
<wire x1="-2.413" y1="-0.762" x2="-2.6416" y2="-0.7112" width="0.1016" layer="21"/>
<wire x1="-2.6416" y1="-0.7112" x2="-2.8448" y2="-0.8128" width="0.1016" layer="21"/>
<wire x1="-2.8448" y1="-0.8128" x2="-2.8956" y2="-0.9398" width="0.1016" layer="21"/>
<wire x1="-2.8956" y1="-0.9398" x2="-2.8194" y2="-1.143" width="0.1016" layer="21"/>
<wire x1="-2.8956" y1="-0.9398" x2="-3.048" y2="-0.9144" width="0.1016" layer="21"/>
<wire x1="-3.048" y1="-0.9144" x2="-3.2512" y2="-1.016" width="0.1016" layer="21"/>
<wire x1="-3.2512" y1="-1.016" x2="-3.3274" y2="-1.143" width="0.1016" layer="21"/>
<wire x1="-2.5654" y1="0.1524" x2="-3.5052" y2="0.1524" width="0.1016" layer="21"/>
<wire x1="-3.5052" y1="0.1524" x2="-3.0226" y2="-0.3048" width="0.1016" layer="21"/>
<wire x1="-3.0226" y1="-0.3048" x2="-3.0226" y2="0.3048" width="0.1016" layer="21"/>
<wire x1="-0.1524" y1="-3.5052" x2="0.1524" y2="-3.5052" width="0.1016" layer="21"/>
<wire x1="0.1524" y1="-3.5052" x2="0.3048" y2="-3.3528" width="0.1016" layer="21"/>
<wire x1="0.3048" y1="-3.3528" x2="0.3048" y2="-2.7432" width="0.1016" layer="21"/>
<wire x1="0.3048" y1="-2.7432" x2="0.1524" y2="-2.5654" width="0.1016" layer="21"/>
<wire x1="0.1524" y1="-2.5654" x2="-0.1524" y2="-2.5654" width="0.1016" layer="21"/>
<wire x1="-0.1524" y1="-2.5654" x2="-0.3048" y2="-2.7432" width="0.1016" layer="21"/>
<wire x1="-0.3048" y1="-2.7432" x2="-0.3048" y2="-3.3528" width="0.1016" layer="21"/>
<wire x1="-0.3048" y1="-3.3528" x2="-0.1524" y2="-3.5052" width="0.1016" layer="21"/>
<wire x1="-0.127" y1="2.5654" x2="0.1778" y2="2.5654" width="0.1016" layer="21"/>
<wire x1="0.1778" y1="2.5654" x2="0.3302" y2="2.7178" width="0.1016" layer="21"/>
<wire x1="0.3302" y1="2.7178" x2="0.3302" y2="2.8702" width="0.1016" layer="21"/>
<wire x1="0.3302" y1="2.8702" x2="0.1778" y2="3.0226" width="0.1016" layer="21"/>
<wire x1="0.1778" y1="3.0226" x2="0.3302" y2="3.175" width="0.1016" layer="21"/>
<wire x1="0.3302" y1="3.175" x2="0.3302" y2="3.3274" width="0.1016" layer="21"/>
<wire x1="0.3302" y1="3.3274" x2="0.1778" y2="3.5052" width="0.1016" layer="21"/>
<wire x1="0.1778" y1="3.5052" x2="-0.127" y2="3.5052" width="0.1016" layer="21"/>
<wire x1="-0.127" y1="3.5052" x2="-0.2794" y2="3.3274" width="0.1016" layer="21"/>
<wire x1="-0.2794" y1="3.3274" x2="-0.2794" y2="3.175" width="0.1016" layer="21"/>
<wire x1="-0.2794" y1="3.175" x2="-0.127" y2="3.0226" width="0.1016" layer="21"/>
<wire x1="-0.127" y1="3.0226" x2="-0.2794" y2="2.8702" width="0.1016" layer="21"/>
<wire x1="-0.2794" y1="2.8702" x2="-0.2794" y2="2.7178" width="0.1016" layer="21"/>
<wire x1="-0.2794" y1="2.7178" x2="-0.127" y2="2.5654" width="0.1016" layer="21"/>
<wire x1="-0.127" y1="3.0226" x2="0.1778" y2="3.0226" width="0.1016" layer="21"/>
<circle x="0" y="0" radius="1.8034" width="0.0508" layer="21"/>
<pad name="8" x="3.81" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="4" x="1.27" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="2" x="-1.27" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="1" x="-3.81" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="C" x="1.27" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<text x="-5.08" y="5.588" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-7.366" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-0.254" y1="-1.016" x2="0.254" y2="1.524" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="SW_4POS">
<wire x1="2.54" y1="5.08" x2="0.254" y2="2.794" width="0.254" layer="94"/>
<wire x1="2.4892" y1="0" x2="1.27" y2="0" width="0.254" layer="94"/>
<wire x1="2.4892" y1="-5.0292" x2="0.254" y2="-2.794" width="0.254" layer="94"/>
<wire x1="0.254" y1="2.794" x2="-1.778" y2="1.778" width="0.254" layer="94"/>
<wire x1="-1.778" y1="1.778" x2="-1.27" y2="1.27" width="0.254" layer="94"/>
<wire x1="-0.762" y1="0.762" x2="0.254" y2="2.794" width="0.254" layer="94"/>
<wire x1="-1.27" y1="1.27" x2="-2.4892" y2="0.0508" width="0.254" layer="94"/>
<wire x1="-1.27" y1="1.27" x2="-0.762" y2="0.762" width="0.254" layer="94"/>
<wire x1="2.54" y1="9.8298" x2="0.3048" y2="7.5946" width="0.254" layer="94"/>
<text x="-12.7" y="3.175" size="1.778" layer="95">&gt;NAME</text>
<text x="-12.7" y="-5.08" size="1.778" layer="96">&gt;VALUE</text>
<pin name="C" x="-5.08" y="0" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="4" x="5.08" y="5.08" visible="pad" length="short" direction="pas" function="dot" rot="R180"/>
<pin name="2" x="5.08" y="0" visible="pad" length="short" direction="pas" function="dot" rot="R180"/>
<pin name="1" x="5.08" y="-5.08" visible="pad" length="short" direction="pas" function="dot" rot="R180"/>
<pin name="8" x="5.08" y="10.16" visible="pad" length="short" direction="pas" function="dot" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="SW-C16" prefix="SW" uservalue="yes">
<description>&lt;b&gt;SWITCH&lt;/b&gt;&lt;p&gt;
16-step rotary switch</description>
<gates>
<gate name="G$1" symbol="SW_4POS" x="2.54" y="0"/>
</gates>
<devices>
<device name="" package="SW-C16">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="8" pad="8"/>
<connect gate="G$1" pin="C" pad="C"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="jumper">
<description>&lt;b&gt;Jumpers&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="JP1">
<description>&lt;b&gt;JUMPER&lt;/b&gt;</description>
<wire x1="-1.016" y1="0" x2="-1.27" y2="0.254" width="0.1524" layer="21"/>
<wire x1="-1.016" y1="0" x2="-1.27" y2="-0.254" width="0.1524" layer="21"/>
<wire x1="1.016" y1="0" x2="1.27" y2="0.254" width="0.1524" layer="21"/>
<wire x1="1.016" y1="0" x2="1.27" y2="-0.254" width="0.1524" layer="21"/>
<wire x1="1.27" y1="-0.254" x2="1.27" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="1.016" y1="-2.54" x2="1.27" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="1.27" y1="2.286" x2="1.016" y2="2.54" width="0.1524" layer="21"/>
<wire x1="1.27" y1="2.286" x2="1.27" y2="0.254" width="0.1524" layer="21"/>
<wire x1="1.016" y1="2.54" x2="-1.016" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="2.286" x2="-1.016" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="2.286" x2="-1.27" y2="0.254" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="-0.254" x2="-1.27" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-1.016" y1="-2.54" x2="-1.27" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-1.016" y1="-2.54" x2="1.016" y2="-2.54" width="0.1524" layer="21"/>
<pad name="1" x="0" y="-1.27" drill="0.9144" shape="long"/>
<pad name="2" x="0" y="1.27" drill="0.9144" shape="long"/>
<text x="-1.651" y="-2.54" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="2.921" y="-2.54" size="1.27" layer="27" ratio="10" rot="R90">&gt;VALUE</text>
<rectangle x1="-0.3048" y1="0.9652" x2="0.3048" y2="1.5748" layer="51"/>
<rectangle x1="-0.3048" y1="-1.5748" x2="0.3048" y2="-0.9652" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="JP2E">
<wire x1="0" y1="0" x2="0" y2="1.27" width="0.1524" layer="94"/>
<wire x1="0" y1="2.54" x2="0" y2="1.27" width="0.4064" layer="94"/>
<wire x1="2.54" y1="0" x2="2.54" y2="1.27" width="0.1524" layer="94"/>
<wire x1="2.54" y1="2.54" x2="2.54" y2="1.27" width="0.4064" layer="94"/>
<wire x1="-0.635" y1="0" x2="3.175" y2="0" width="0.4064" layer="94"/>
<wire x1="3.175" y1="0" x2="3.175" y2="0.635" width="0.4064" layer="94"/>
<wire x1="3.175" y1="0.635" x2="-0.635" y2="0.635" width="0.4064" layer="94"/>
<wire x1="-0.635" y1="0.635" x2="-0.635" y2="0" width="0.4064" layer="94"/>
<text x="-1.27" y="0" size="1.778" layer="95" rot="R90">&gt;NAME</text>
<text x="5.715" y="0" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="1" x="0" y="-2.54" visible="pad" length="short" direction="pas" rot="R90"/>
<pin name="2" x="2.54" y="-2.54" visible="pad" length="short" direction="pas" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="JP1E" prefix="JP" uservalue="yes">
<description>&lt;b&gt;JUMPER&lt;/b&gt;</description>
<gates>
<gate name="A" symbol="JP2E" x="2.54" y="0"/>
</gates>
<devices>
<device name="" package="JP1">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="resistor-sil">
<description>&lt;b&gt;Resistors in Single Inline Packages&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="SIL6">
<description>&lt;b&gt;Single In Line&lt;/b&gt;</description>
<wire x1="-7.62" y1="0.508" x2="-7.62" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="-7.112" y1="0.762" x2="-5.588" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-5.588" y1="0.762" x2="-5.588" y2="-0.762" width="0.1524" layer="51"/>
<wire x1="-5.588" y1="-0.762" x2="-7.112" y2="-0.762" width="0.1524" layer="51"/>
<wire x1="-7.112" y1="-0.762" x2="-7.112" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-5.461" y1="0.889" x2="-5.461" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="-5.461" y1="-0.889" x2="-7.239" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.508" x2="-7.112" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="7.112" y1="-1.016" x2="7.62" y2="-0.508" width="0.1524" layer="21" curve="90"/>
<wire x1="7.112" y1="1.016" x2="7.62" y2="0.508" width="0.1524" layer="21" curve="-90"/>
<wire x1="-7.62" y1="-0.508" x2="-7.112" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="7.62" y1="0.508" x2="7.62" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="-7.112" y1="1.016" x2="7.112" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-7.112" y1="-1.016" x2="7.112" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-5.461" y1="0.889" x2="-7.239" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-7.239" y1="0.889" x2="-7.239" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="-1.778" y1="0" x2="-1.143" y2="0" width="0.1524" layer="51"/>
<wire x1="1.778" y1="0" x2="1.143" y2="0" width="0.1524" layer="51"/>
<wire x1="-1.143" y1="0.381" x2="1.143" y2="0.381" width="0.1524" layer="51"/>
<wire x1="1.143" y1="0.381" x2="1.143" y2="0" width="0.1524" layer="51"/>
<wire x1="1.143" y1="0" x2="1.143" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="1.143" y1="-0.381" x2="-1.143" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-1.143" y1="-0.381" x2="-1.143" y2="0" width="0.1524" layer="51"/>
<wire x1="-1.143" y1="0" x2="-1.143" y2="0.381" width="0.1524" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="0.8128" shape="long" rot="R90"/>
<pad name="2" x="-3.81" y="0" drill="0.8128" shape="long" rot="R90"/>
<pad name="3" x="-1.27" y="0" drill="0.8128" shape="long" rot="R90"/>
<pad name="4" x="1.27" y="0" drill="0.8128" shape="long" rot="R90"/>
<pad name="5" x="3.81" y="0" drill="0.8128" shape="long" rot="R90"/>
<pad name="6" x="6.35" y="0" drill="0.8128" shape="long" rot="R90"/>
<text x="-7.62" y="1.27" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.635" y="1.27" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-8.636" y="-0.508" size="0.9906" layer="21" ratio="12">1</text>
</package>
</packages>
<symbols>
<symbol name="R5">
<wire x1="-4.318" y1="-1.27" x2="-4.318" y2="3.81" width="0.254" layer="94"/>
<wire x1="-5.842" y1="3.81" x2="-5.842" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-4.318" y1="3.81" x2="-5.08" y2="3.81" width="0.254" layer="94"/>
<wire x1="-5.842" y1="-1.27" x2="-5.08" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-5.08" y1="-1.27" x2="-5.08" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="-1.27" x2="-4.318" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-5.08" y1="5.08" x2="-5.08" y2="3.81" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="3.81" x2="-5.842" y2="3.81" width="0.254" layer="94"/>
<wire x1="-5.08" y1="5.08" x2="-2.54" y2="5.08" width="0.1524" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="-2.54" y2="3.81" width="0.1524" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="0" y2="5.08" width="0.1524" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="3.81" width="0.1524" layer="94"/>
<wire x1="0" y1="5.08" x2="2.54" y2="5.08" width="0.1524" layer="94"/>
<wire x1="2.54" y1="5.08" x2="2.54" y2="3.81" width="0.1524" layer="94"/>
<wire x1="2.54" y1="5.08" x2="5.08" y2="5.08" width="0.1524" layer="94"/>
<wire x1="5.08" y1="5.08" x2="5.08" y2="3.81" width="0.1524" layer="94"/>
<wire x1="5.08" y1="-2.54" x2="5.08" y2="-1.27" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-2.54" x2="2.54" y2="-1.27" width="0.1524" layer="94"/>
<wire x1="0" y1="-2.54" x2="0" y2="-1.27" width="0.1524" layer="94"/>
<wire x1="-2.54" y1="-2.54" x2="-2.54" y2="-1.27" width="0.1524" layer="94"/>
<wire x1="-2.54" y1="-1.27" x2="-1.778" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-3.302" y1="-1.27" x2="-2.54" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-1.778" y1="3.81" x2="-2.54" y2="3.81" width="0.254" layer="94"/>
<wire x1="-2.54" y1="3.81" x2="-3.302" y2="3.81" width="0.254" layer="94"/>
<wire x1="-1.778" y1="-1.27" x2="-1.778" y2="3.81" width="0.254" layer="94"/>
<wire x1="-3.302" y1="3.81" x2="-3.302" y2="-1.27" width="0.254" layer="94"/>
<wire x1="0.762" y1="-1.27" x2="0.762" y2="3.81" width="0.254" layer="94"/>
<wire x1="3.302" y1="-1.27" x2="3.302" y2="3.81" width="0.254" layer="94"/>
<wire x1="5.842" y1="-1.27" x2="5.842" y2="3.81" width="0.254" layer="94"/>
<wire x1="-0.762" y1="3.81" x2="-0.762" y2="-1.27" width="0.254" layer="94"/>
<wire x1="1.778" y1="3.81" x2="1.778" y2="-1.27" width="0.254" layer="94"/>
<wire x1="4.318" y1="3.81" x2="4.318" y2="-1.27" width="0.254" layer="94"/>
<wire x1="0.762" y1="3.81" x2="0" y2="3.81" width="0.254" layer="94"/>
<wire x1="3.302" y1="3.81" x2="2.54" y2="3.81" width="0.254" layer="94"/>
<wire x1="5.842" y1="3.81" x2="5.08" y2="3.81" width="0.254" layer="94"/>
<wire x1="0" y1="3.81" x2="-0.762" y2="3.81" width="0.254" layer="94"/>
<wire x1="2.54" y1="3.81" x2="1.778" y2="3.81" width="0.254" layer="94"/>
<wire x1="5.08" y1="3.81" x2="4.318" y2="3.81" width="0.254" layer="94"/>
<wire x1="0" y1="-1.27" x2="0.762" y2="-1.27" width="0.254" layer="94"/>
<wire x1="2.54" y1="-1.27" x2="3.302" y2="-1.27" width="0.254" layer="94"/>
<wire x1="5.08" y1="-1.27" x2="5.842" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-0.762" y1="-1.27" x2="0" y2="-1.27" width="0.254" layer="94"/>
<wire x1="1.778" y1="-1.27" x2="2.54" y2="-1.27" width="0.254" layer="94"/>
<wire x1="4.318" y1="-1.27" x2="5.08" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-7.62" y1="-2.54" x2="-7.62" y2="6.35" width="0.4064" layer="94"/>
<wire x1="-7.62" y1="6.35" x2="7.62" y2="6.35" width="0.4064" layer="94"/>
<wire x1="7.62" y1="6.35" x2="7.62" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="-7.62" y1="-2.54" x2="7.62" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="5.08" x2="-5.08" y2="7.62" width="0.1524" layer="94"/>
<circle x="2.54" y="5.08" radius="0.254" width="0.4064" layer="94"/>
<circle x="0" y="5.08" radius="0.254" width="0.4064" layer="94"/>
<circle x="-2.54" y="5.08" radius="0.254" width="0.4064" layer="94"/>
<circle x="-5.08" y="5.08" radius="0.254" width="0.4064" layer="94"/>
<text x="-2.54" y="8.89" size="1.778" layer="95">&gt;NAME</text>
<text x="-2.54" y="6.985" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="10.16" visible="pad" length="short" direction="pas" rot="R270"/>
<pin name="2" x="-5.08" y="-5.08" visible="pad" length="short" direction="pas" swaplevel="1" rot="R90"/>
<pin name="3" x="-2.54" y="-5.08" visible="pad" length="short" direction="pas" swaplevel="1" rot="R90"/>
<pin name="4" x="0" y="-5.08" visible="pad" length="short" direction="pas" swaplevel="1" rot="R90"/>
<pin name="5" x="2.54" y="-5.08" visible="pad" length="short" direction="pas" swaplevel="1" rot="R90"/>
<pin name="6" x="5.08" y="-5.08" visible="pad" length="short" direction="pas" swaplevel="1" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="G05R" prefix="RN" uservalue="yes">
<description>&lt;b&gt;SIL RESISTOR&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="R5" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SIL6">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="74xx-little-de">
<description>&lt;b&gt;Single and Dual Gates Family, US symbols&lt;/b&gt;&lt;p&gt;
Little logic devices from Texas Instruments&lt;br&gt;
TinyLogic(R) from FAIRCHILD Semiconductor TM
&lt;p&gt;
&lt;author&gt;Created by evgeni@eniks.com&lt;/author&gt;&lt;br&gt;
&lt;author&gt;Extended by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="YZP_R-XBGA-N6">
<description>&lt;b&gt;YZP (R-XBGA-N6)&lt;/b&gt; DIE-SIZE BALL GRID ARRAY&lt;p&gt;
NanoFree TM -  WCSP (DSBGA) 0.23-mm Large Bump - YZP (Pb-free)&lt;br&gt;
Source: http://focus.ti.com/lit/ds/symlink/sn74lvc1g3157</description>
<wire x1="-0.675" y1="0.425" x2="0.675" y2="0.425" width="0.1016" layer="51"/>
<wire x1="0.675" y1="0.425" x2="0.675" y2="-0.425" width="0.1016" layer="51"/>
<wire x1="0.675" y1="-0.425" x2="-0.675" y2="-0.425" width="0.1016" layer="51"/>
<wire x1="-0.675" y1="-0.425" x2="-0.675" y2="0.425" width="0.1016" layer="51"/>
<circle x="-0.5" y="-0.25" radius="0.175" width="0" layer="29"/>
<circle x="0" y="-0.25" radius="0.175" width="0" layer="29"/>
<circle x="0.5" y="-0.25" radius="0.175" width="0" layer="29"/>
<circle x="0.5" y="0.25" radius="0.175" width="0" layer="29"/>
<circle x="0" y="0.25" radius="0.175" width="0" layer="29"/>
<circle x="-0.5" y="0.25" radius="0.175" width="0" layer="29"/>
<smd name="A1" x="-0.5" y="-0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="B1" x="0" y="-0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="C1" x="0.5" y="-0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="C2" x="0.5" y="0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="B2" x="0" y="0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="A2" x="-0.5" y="0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<text x="-0.725" y="0.725" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.725" y="-2.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.675" y1="-0.4" x2="-0.225" y2="-0.175" layer="51"/>
<rectangle x1="-0.3" y1="-0.375" x2="-0.225" y2="-0.175" layer="21"/>
</package>
<package name="DBV_R-PDSO-G6">
<description>&lt;b&gt;DBV (R-PDSO-G6)&lt;/b&gt; PLASTIC SMALL-OUTLINE PACKAGE&lt;p&gt;
SOT (SOT-23) - DBV&lt;br&gt;
Source: http://focus.ti.com/lit/ds/symlink/sn74lvc1g3157.</description>
<wire x1="0" y1="-1.29" x2="0" y2="-1.3" width="0.01" layer="21"/>
<wire x1="1.42" y1="0.8" x2="1.42" y2="-0.8" width="0.127" layer="21"/>
<wire x1="1.42" y1="-0.8" x2="-1.42" y2="-0.8" width="0.127" layer="51"/>
<wire x1="-1.42" y1="-0.8" x2="-1.42" y2="0.8" width="0.127" layer="21"/>
<wire x1="-1.42" y1="0.8" x2="1.42" y2="0.8" width="0.127" layer="51"/>
<smd name="1" x="-0.95" y="-1.29" dx="0.69" dy="0.99" layer="1" stop="no"/>
<smd name="2" x="0" y="-1.29" dx="0.69" dy="0.99" layer="1" stop="no"/>
<smd name="3" x="0.95" y="-1.29" dx="0.69" dy="0.99" layer="1" stop="no"/>
<smd name="4" x="0.95" y="1.3" dx="0.69" dy="0.99" layer="1" stop="no"/>
<smd name="6" x="-0.95" y="1.3" dx="0.69" dy="0.99" layer="1" stop="no"/>
<smd name="5" x="0" y="1.3" dx="0.69" dy="0.99" layer="1" stop="no"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.11" y1="0.8" x2="-0.78" y2="1.43" layer="51"/>
<rectangle x1="0.79" y1="0.8" x2="1.12" y2="1.42" layer="51"/>
<rectangle x1="-1.11" y1="-1.42" x2="-0.78" y2="-0.8" layer="51"/>
<rectangle x1="-0.16" y1="-1.42" x2="0.17" y2="-0.8" layer="51"/>
<rectangle x1="0.79" y1="-1.42" x2="1.12" y2="-0.8" layer="51"/>
<rectangle x1="-0.16" y1="0.8" x2="0.17" y2="1.42" layer="51"/>
<rectangle x1="-1.35" y1="0.75" x2="-0.55" y2="1.85" layer="29"/>
<rectangle x1="-0.4" y1="0.75" x2="0.4" y2="1.85" layer="29"/>
<rectangle x1="0.55" y1="0.75" x2="1.35" y2="1.85" layer="29"/>
<rectangle x1="0.55" y1="-1.85" x2="1.35" y2="-0.75" layer="29" rot="R180"/>
<rectangle x1="-0.4" y1="-1.85" x2="0.4" y2="-0.75" layer="29" rot="R180"/>
<rectangle x1="-1.35" y1="-1.85" x2="-0.55" y2="-0.75" layer="29" rot="R180"/>
<rectangle x1="-1.375" y1="-0.75" x2="-0.625" y2="0" layer="21"/>
</package>
<package name="DCK_R-PDSO-G6">
<description>&lt;b&gt;DCK (R-PDSO-G6)&lt;/b&gt; PLASTIC SMALL-OUTLINE PACKAGE&lt;p&gt;
SOT (SC-70) - DCK&lt;br&gt;
Source: http://focus.ti.com/lit/ds/symlink/sn74lvc1g3157.</description>
<wire x1="1" y1="0.55" x2="-1" y2="0.55" width="0.127" layer="51"/>
<wire x1="-1" y1="0.55" x2="-1" y2="-0.55" width="0.127" layer="21"/>
<wire x1="-1" y1="-0.55" x2="1" y2="-0.55" width="0.127" layer="51"/>
<wire x1="1" y1="-0.55" x2="1" y2="0.55" width="0.127" layer="21"/>
<smd name="1" x="-0.65" y="-0.85" dx="0.4" dy="0.7" layer="1"/>
<smd name="2" x="0" y="-0.85" dx="0.4" dy="0.7" layer="1"/>
<smd name="3" x="0.65" y="-0.85" dx="0.4" dy="0.7" layer="1"/>
<smd name="4" x="0.65" y="0.85" dx="0.4" dy="0.7" layer="1"/>
<smd name="6" x="-0.65" y="0.85" dx="0.4" dy="0.7" layer="1"/>
<smd name="5" x="0" y="0.85" dx="0.4" dy="0.7" layer="1"/>
<text x="-2.54" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.125" y1="-1.05" x2="0.125" y2="-0.6" layer="51"/>
<rectangle x1="-0.775" y1="-1.05" x2="-0.525" y2="-0.6" layer="51"/>
<rectangle x1="0.525" y1="-1.05" x2="0.775" y2="-0.6" layer="51"/>
<rectangle x1="-0.775" y1="0.6" x2="-0.525" y2="1.05" layer="51"/>
<rectangle x1="0.525" y1="0.6" x2="0.775" y2="1.05" layer="51"/>
<rectangle x1="-0.125" y1="0.6" x2="0.125" y2="1.05" layer="51"/>
<rectangle x1="-0.95" y1="-0.5" x2="-0.275" y2="0" layer="21"/>
</package>
<package name="DRL_R-PDSO-N6">
<description>&lt;b&gt;DRL (R-PDSO-N6)&lt;/b&gt; PLASTIC SMALL OUTLINE&lt;p&gt;
SOT (SOT-553) -  DRL&lt;br&gt;
Source: http://focus.ti.com/lit/ds/symlink/sn74lvc1g3157.pdf</description>
<wire x1="-0.8" y1="0.6" x2="0.8" y2="0.6" width="0.1016" layer="51"/>
<wire x1="0.8" y1="0.6" x2="0.8" y2="-0.6" width="0.1016" layer="21"/>
<wire x1="0.8" y1="-0.6" x2="-0.8" y2="-0.6" width="0.1016" layer="51"/>
<wire x1="-0.8" y1="-0.6" x2="-0.8" y2="0.6" width="0.1016" layer="21"/>
<smd name="1" x="-0.5" y="-0.675" dx="0.35" dy="0.55" layer="1" stop="no"/>
<smd name="2" x="0" y="-0.675" dx="0.35" dy="0.55" layer="1" stop="no"/>
<smd name="3" x="0.5" y="-0.675" dx="0.35" dy="0.55" layer="1" stop="no"/>
<smd name="4" x="0.5" y="0.675" dx="0.35" dy="0.55" layer="1" rot="R180" stop="no"/>
<smd name="5" x="0" y="0.675" dx="0.35" dy="0.55" layer="1" rot="R180" stop="no"/>
<smd name="6" x="-0.5" y="0.675" dx="0.35" dy="0.55" layer="1" rot="R180" stop="no"/>
<text x="-1" y="1" size="1.27" layer="25">&gt;NAME</text>
<text x="-1" y="-2.5" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.775" y1="-0.575" x2="0" y2="0" layer="51"/>
<rectangle x1="-0.625" y1="-0.85" x2="-0.375" y2="-0.45" layer="51"/>
<rectangle x1="-0.7" y1="-0.975" x2="-0.3" y2="-0.375" layer="29"/>
<rectangle x1="-0.125" y1="-0.85" x2="0.125" y2="-0.45" layer="51"/>
<rectangle x1="-0.2" y1="-0.975" x2="0.2" y2="-0.375" layer="29"/>
<rectangle x1="0.375" y1="-0.85" x2="0.625" y2="-0.45" layer="51"/>
<rectangle x1="0.3" y1="-0.975" x2="0.7" y2="-0.375" layer="29"/>
<rectangle x1="0.375" y1="0.45" x2="0.625" y2="0.85" layer="51" rot="R180"/>
<rectangle x1="0.3" y1="0.375" x2="0.7" y2="0.975" layer="29" rot="R180"/>
<rectangle x1="-0.125" y1="0.45" x2="0.125" y2="0.85" layer="51" rot="R180"/>
<rectangle x1="-0.2" y1="0.375" x2="0.2" y2="0.975" layer="29" rot="R180"/>
<rectangle x1="-0.625" y1="0.45" x2="-0.375" y2="0.85" layer="51" rot="R180"/>
<rectangle x1="-0.7" y1="0.375" x2="-0.3" y2="0.975" layer="29" rot="R180"/>
<rectangle x1="-0.75" y1="-0.325" x2="0" y2="0" layer="21"/>
</package>
<package name="YEP_R-XBGA-N6">
<description>&lt;b&gt;YEP (R-XBGA-N6)&lt;/b&gt; DIE-SIZE BALL GRID ARRAY&lt;p&gt;
NanoStar TM - WCSP (DSBG A)0.23-mm Large Bump - YEP&lt;br&gt;
Source: http://focus.ti.com/lit/ds/symlink/sn74lvc1g3157</description>
<wire x1="-0.675" y1="0.425" x2="0.675" y2="0.425" width="0.1016" layer="51"/>
<wire x1="0.675" y1="0.425" x2="0.675" y2="-0.425" width="0.1016" layer="51"/>
<wire x1="0.675" y1="-0.425" x2="-0.675" y2="-0.425" width="0.1016" layer="51"/>
<wire x1="-0.675" y1="-0.425" x2="-0.675" y2="0.425" width="0.1016" layer="51"/>
<circle x="-0.5" y="-0.25" radius="0.175" width="0" layer="29"/>
<circle x="0" y="-0.25" radius="0.175" width="0" layer="29"/>
<circle x="0.5" y="-0.25" radius="0.175" width="0" layer="29"/>
<circle x="0.5" y="0.25" radius="0.175" width="0" layer="29"/>
<circle x="0" y="0.25" radius="0.175" width="0" layer="29"/>
<circle x="-0.5" y="0.25" radius="0.175" width="0" layer="29"/>
<smd name="A1" x="-0.5" y="-0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="B1" x="0" y="-0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="C1" x="0.5" y="-0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="C2" x="0.5" y="0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="B2" x="0" y="0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<smd name="A2" x="-0.5" y="0.25" dx="0.3" dy="0.3" layer="1" roundness="100" stop="no" cream="no"/>
<text x="-0.725" y="0.725" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.725" y="-2.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.675" y1="-0.4" x2="-0.225" y2="-0.175" layer="51"/>
<rectangle x1="-0.3" y1="-0.375" x2="-0.225" y2="-0.175" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="743157">
<wire x1="-5.08" y1="-5.08" x2="7.62" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="7.62" y1="-5.08" x2="7.62" y2="7.62" width="0.4064" layer="94"/>
<wire x1="7.62" y1="7.62" x2="-5.08" y2="7.62" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="7.62" x2="-5.08" y2="-5.08" width="0.4064" layer="94"/>
<text x="-5.08" y="8.255" size="1.778" layer="95">&gt;NAME</text>
<text x="-5.08" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="!A!/B" x="-7.62" y="-2.54" length="short" direction="in"/>
<pin name="A" x="-7.62" y="5.08" length="short"/>
<pin name="B" x="-7.62" y="2.54" length="short"/>
<pin name="X" x="10.16" y="2.54" length="short" rot="R180"/>
</symbol>
<symbol name="PWRN">
<text x="-0.635" y="-0.635" size="1.778" layer="95">&gt;NAME</text>
<text x="1.905" y="-6.35" size="1.27" layer="95" rot="R90">GND</text>
<text x="1.905" y="2.54" size="1.27" layer="95" rot="R90">VCC</text>
<pin name="GND" x="0" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="VCC" x="0" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="74*1G3157" prefix="IC">
<description>&lt;b&gt;Single-Pole, Double-Throw Analog Switch&lt;/b&gt;&lt;p&gt;
Source: http://focus.ti.com/lit/ds/symlink/sn74lvc1g3157.pdf</description>
<gates>
<gate name="G$1" symbol="743157" x="0" y="0"/>
<gate name="P" symbol="PWRN" x="17.78" y="0" addlevel="request"/>
</gates>
<devices>
<device name="ZYPR" package="YZP_R-XBGA-N6">
<connects>
<connect gate="G$1" pin="!A!/B" pad="A2"/>
<connect gate="G$1" pin="A" pad="C1"/>
<connect gate="G$1" pin="B" pad="A1"/>
<connect gate="G$1" pin="X" pad="C2"/>
<connect gate="P" pin="GND" pad="B1"/>
<connect gate="P" pin="VCC" pad="B2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="DBVR" package="DBV_R-PDSO-G6">
<connects>
<connect gate="G$1" pin="!A!/B" pad="6"/>
<connect gate="G$1" pin="A" pad="3"/>
<connect gate="G$1" pin="B" pad="1"/>
<connect gate="G$1" pin="X" pad="4"/>
<connect gate="P" pin="GND" pad="2"/>
<connect gate="P" pin="VCC" pad="5"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="DCKR" package="DCK_R-PDSO-G6">
<connects>
<connect gate="G$1" pin="!A!/B" pad="6"/>
<connect gate="G$1" pin="A" pad="3"/>
<connect gate="G$1" pin="B" pad="1"/>
<connect gate="G$1" pin="X" pad="4"/>
<connect gate="P" pin="GND" pad="2"/>
<connect gate="P" pin="VCC" pad="5"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="DRLR" package="DRL_R-PDSO-N6">
<connects>
<connect gate="G$1" pin="!A!/B" pad="6"/>
<connect gate="G$1" pin="A" pad="3"/>
<connect gate="G$1" pin="B" pad="1"/>
<connect gate="G$1" pin="X" pad="4"/>
<connect gate="P" pin="GND" pad="2"/>
<connect gate="P" pin="VCC" pad="5"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="YEPR" package="YEP_R-XBGA-N6">
<connects>
<connect gate="G$1" pin="!A!/B" pad="A2"/>
<connect gate="G$1" pin="A" pad="C1"/>
<connect gate="G$1" pin="B" pad="A1"/>
<connect gate="G$1" pin="X" pad="C2"/>
<connect gate="P" pin="GND" pad="B1"/>
<connect gate="P" pin="VCC" pad="B2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="SPECTRUM">
<packages>
<package name="BUS_CARTUCHO_IF2">
<description>Bus cartucho IF2</description>
<smd name="A0" x="-27.305" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A1" x="-24.765" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A2" x="-22.225" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A3" x="-19.685" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A4" x="-17.145" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A5" x="-14.605" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A6" x="-9.525" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A7" x="-6.985" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A8" x="-9.525" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="A9" x="-14.605" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="A10" x="-22.225" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="A11" x="-17.145" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="A12" x="-4.445" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="A13" x="-6.985" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="A14" x="-24.765" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="A15" x="-4.445" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="D0" x="-29.845" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="D1" x="-32.385" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="D2" x="-34.925" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="D3" x="-37.465" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="D4" x="-34.925" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="D5" x="-32.385" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="D6" x="-29.845" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="D7" x="-27.305" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="GND" x="-37.465" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="MREQ" x="-19.685" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="ROMCS" x="-1.905" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="VCC" x="-1.905" y="3.175" dx="1.27" dy="6.35" layer="1"/>
<smd name="RD" x="0.635" y="3.175" dx="1.27" dy="6.35" layer="16"/>
<smd name="WR" x="0.635" y="3.175" dx="1.27" dy="6.35" layer="1"/>
</package>
</packages>
<symbols>
<symbol name="CONECTOR-BUS">
<wire x1="-30.48" y1="33.02" x2="-30.48" y2="-53.34" width="0.254" layer="94"/>
<wire x1="-30.48" y1="-53.34" x2="-10.16" y2="-53.34" width="0.254" layer="94"/>
<wire x1="-10.16" y1="-53.34" x2="-10.16" y2="33.02" width="0.254" layer="94"/>
<wire x1="-10.16" y1="33.02" x2="-30.48" y2="33.02" width="0.254" layer="94"/>
<pin name="+5V" x="-5.08" y="-22.86" length="middle" rot="R180"/>
<pin name="A0" x="-35.56" y="27.94" length="middle"/>
<pin name="A1" x="-35.56" y="22.86" length="middle"/>
<pin name="A2" x="-35.56" y="17.78" length="middle"/>
<pin name="A3" x="-35.56" y="12.7" length="middle"/>
<pin name="A4" x="-35.56" y="7.62" length="middle"/>
<pin name="A5" x="-35.56" y="2.54" length="middle"/>
<pin name="A6" x="-35.56" y="-2.54" length="middle"/>
<pin name="A7" x="-35.56" y="-7.62" length="middle"/>
<pin name="A8" x="-35.56" y="-12.7" length="middle"/>
<pin name="A9" x="-35.56" y="-17.78" length="middle"/>
<pin name="A10" x="-35.56" y="-22.86" length="middle"/>
<pin name="A11" x="-35.56" y="-27.94" length="middle"/>
<pin name="A12" x="-35.56" y="-33.02" length="middle"/>
<pin name="A13" x="-35.56" y="-38.1" length="middle"/>
<pin name="A14" x="-35.56" y="-43.18" length="middle"/>
<pin name="A15" x="-35.56" y="-48.26" length="middle"/>
<pin name="D0" x="-5.08" y="27.94" length="middle" rot="R180"/>
<pin name="D1" x="-5.08" y="22.86" length="middle" rot="R180"/>
<pin name="D2" x="-5.08" y="17.78" length="middle" rot="R180"/>
<pin name="D3" x="-5.08" y="12.7" length="middle" rot="R180"/>
<pin name="D4" x="-5.08" y="7.62" length="middle" rot="R180"/>
<pin name="D5" x="-5.08" y="2.54" length="middle" rot="R180"/>
<pin name="D6" x="-5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="D7" x="-5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="GND" x="-5.08" y="-27.94" length="middle" rot="R180"/>
<pin name="MEMREQ" x="-5.08" y="-12.7" length="middle" rot="R180"/>
<pin name="ROMCS" x="-5.08" y="-17.78" length="middle" rot="R180"/>
<pin name="RD" x="-5.08" y="-33.02" length="middle" rot="R180"/>
<pin name="WR" x="-5.08" y="-38.1" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="IF2BUS">
<gates>
<gate name="G$1" symbol="CONECTOR-BUS" x="20.32" y="7.62"/>
</gates>
<devices>
<device name="" package="BUS_CARTUCHO_IF2">
<connects>
<connect gate="G$1" pin="+5V" pad="VCC"/>
<connect gate="G$1" pin="A0" pad="A0"/>
<connect gate="G$1" pin="A1" pad="A1"/>
<connect gate="G$1" pin="A10" pad="A10"/>
<connect gate="G$1" pin="A11" pad="A11"/>
<connect gate="G$1" pin="A12" pad="A12"/>
<connect gate="G$1" pin="A13" pad="A13"/>
<connect gate="G$1" pin="A14" pad="A14"/>
<connect gate="G$1" pin="A15" pad="A15"/>
<connect gate="G$1" pin="A2" pad="A2"/>
<connect gate="G$1" pin="A3" pad="A3"/>
<connect gate="G$1" pin="A4" pad="A4"/>
<connect gate="G$1" pin="A5" pad="A5"/>
<connect gate="G$1" pin="A6" pad="A6"/>
<connect gate="G$1" pin="A7" pad="A7"/>
<connect gate="G$1" pin="A8" pad="A8"/>
<connect gate="G$1" pin="A9" pad="A9"/>
<connect gate="G$1" pin="D0" pad="D0"/>
<connect gate="G$1" pin="D1" pad="D1"/>
<connect gate="G$1" pin="D2" pad="D2"/>
<connect gate="G$1" pin="D3" pad="D3"/>
<connect gate="G$1" pin="D4" pad="D4"/>
<connect gate="G$1" pin="D5" pad="D5"/>
<connect gate="G$1" pin="D6" pad="D6"/>
<connect gate="G$1" pin="D7" pad="D7"/>
<connect gate="G$1" pin="GND" pad="GND"/>
<connect gate="G$1" pin="MEMREQ" pad="MREQ"/>
<connect gate="G$1" pin="RD" pad="RD"/>
<connect gate="G$1" pin="ROMCS" pad="ROMCS"/>
<connect gate="G$1" pin="WR" pad="WR"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="SST28SF040" library="memory" deviceset="SST39VF040" device="N" value=""/>
<part name="SW1" library="special" deviceset="SW-C16" device=""/>
<part name="JP1" library="jumper" deviceset="JP1E" device=""/>
<part name="IC741G332" library="74xx-little-de" deviceset="74*1G3157" device="DBVR" value=""/>
<part name="U$1" library="SPECTRUM" deviceset="IF2BUS" device=""/>
<part name="RN2" library="resistor-sil" deviceset="G05R" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="SST28SF040" gate="G$1" x="58.42" y="53.34"/>
<instance part="SW1" gate="G$1" x="17.78" y="58.42" rot="MR180"/>
<instance part="JP1" gate="A" x="20.32" y="43.18"/>
<instance part="IC741G332" gate="G$1" x="15.24" y="27.94"/>
<instance part="U$1" gate="G$1" x="-10.16" y="60.96"/>
<instance part="RN2" gate="G$1" x="30.48" y="78.74"/>
</instances>
<busses>
</busses>
<nets>
<net name="CS" class="0">
<segment>
<wire x1="25.4" y1="30.48" x2="48.26" y2="30.48" width="0.1524" layer="91"/>
<pinref part="SST28SF040" gate="G$1" pin="!CE"/>
<pinref part="IC741G332" gate="G$1" pin="X"/>
<label x="40.64" y="30.48" size="1.778" layer="95"/>
</segment>
</net>
<net name="D0" class="0">
<segment>
<wire x1="-15.24" y1="88.9" x2="-7.62" y2="88.9" width="0.1524" layer="91"/>
<label x="-10.16" y="88.9" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D0"/>
</segment>
<segment>
<wire x1="68.58" y1="81.28" x2="76.2" y2="81.28" width="0.1524" layer="91"/>
<label x="73.66" y="81.28" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D0"/>
</segment>
</net>
<net name="D1" class="0">
<segment>
<wire x1="-15.24" y1="83.82" x2="-7.62" y2="83.82" width="0.1524" layer="91"/>
<label x="-10.16" y="83.82" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D1"/>
</segment>
<segment>
<wire x1="68.58" y1="78.74" x2="76.2" y2="78.74" width="0.1524" layer="91"/>
<label x="73.66" y="78.74" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D1"/>
</segment>
</net>
<net name="D2" class="0">
<segment>
<wire x1="-15.24" y1="78.74" x2="-7.62" y2="78.74" width="0.1524" layer="91"/>
<label x="-10.16" y="78.74" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D2"/>
</segment>
<segment>
<wire x1="68.58" y1="76.2" x2="76.2" y2="76.2" width="0.1524" layer="91"/>
<label x="73.66" y="76.2" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D2"/>
</segment>
</net>
<net name="D3" class="0">
<segment>
<wire x1="-15.24" y1="73.66" x2="-7.62" y2="73.66" width="0.1524" layer="91"/>
<label x="-10.16" y="73.66" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D3"/>
</segment>
<segment>
<wire x1="68.58" y1="73.66" x2="76.2" y2="73.66" width="0.1524" layer="91"/>
<label x="73.66" y="73.66" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D3"/>
</segment>
</net>
<net name="D4" class="0">
<segment>
<wire x1="-15.24" y1="68.58" x2="-7.62" y2="68.58" width="0.1524" layer="91"/>
<label x="-10.16" y="68.58" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D4"/>
</segment>
<segment>
<wire x1="68.58" y1="71.12" x2="76.2" y2="71.12" width="0.1524" layer="91"/>
<label x="73.66" y="71.12" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D4"/>
</segment>
</net>
<net name="D5" class="0">
<segment>
<wire x1="-15.24" y1="63.5" x2="-7.62" y2="63.5" width="0.1524" layer="91"/>
<label x="-10.16" y="63.5" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D5"/>
</segment>
<segment>
<wire x1="68.58" y1="68.58" x2="76.2" y2="68.58" width="0.1524" layer="91"/>
<label x="73.66" y="68.58" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D5"/>
</segment>
</net>
<net name="D6" class="0">
<segment>
<wire x1="-15.24" y1="58.42" x2="-7.62" y2="58.42" width="0.1524" layer="91"/>
<label x="-10.16" y="58.42" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D6"/>
</segment>
<segment>
<wire x1="68.58" y1="66.04" x2="76.2" y2="66.04" width="0.1524" layer="91"/>
<label x="73.66" y="66.04" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D6"/>
</segment>
</net>
<net name="D7" class="0">
<segment>
<wire x1="-15.24" y1="53.34" x2="-7.62" y2="53.34" width="0.1524" layer="91"/>
<label x="-10.16" y="53.34" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="D7"/>
</segment>
<segment>
<wire x1="68.58" y1="63.5" x2="76.2" y2="63.5" width="0.1524" layer="91"/>
<label x="73.66" y="63.5" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="D7"/>
</segment>
</net>
<net name="A0" class="0">
<segment>
<wire x1="-53.34" y1="88.9" x2="-45.72" y2="88.9" width="0.1524" layer="91"/>
<label x="-53.34" y="88.9" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A0"/>
</segment>
<segment>
<wire x1="40.64" y1="81.28" x2="48.26" y2="81.28" width="0.1524" layer="91"/>
<label x="40.64" y="81.28" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A0"/>
</segment>
</net>
<net name="A1" class="0">
<segment>
<wire x1="-53.34" y1="83.82" x2="-45.72" y2="83.82" width="0.1524" layer="91"/>
<label x="-53.34" y="83.82" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A1"/>
</segment>
<segment>
<wire x1="40.64" y1="78.74" x2="48.26" y2="78.74" width="0.1524" layer="91"/>
<label x="40.64" y="78.74" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A1"/>
</segment>
</net>
<net name="A2" class="0">
<segment>
<wire x1="-53.34" y1="78.74" x2="-45.72" y2="78.74" width="0.1524" layer="91"/>
<label x="-53.34" y="78.74" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A2"/>
</segment>
<segment>
<wire x1="40.64" y1="76.2" x2="48.26" y2="76.2" width="0.1524" layer="91"/>
<label x="40.64" y="76.2" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A2"/>
</segment>
</net>
<net name="A3" class="0">
<segment>
<wire x1="-53.34" y1="73.66" x2="-45.72" y2="73.66" width="0.1524" layer="91"/>
<label x="-53.34" y="73.66" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A3"/>
</segment>
<segment>
<wire x1="40.64" y1="73.66" x2="48.26" y2="73.66" width="0.1524" layer="91"/>
<label x="40.64" y="73.66" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A3"/>
</segment>
</net>
<net name="A4" class="0">
<segment>
<wire x1="-53.34" y1="68.58" x2="-45.72" y2="68.58" width="0.1524" layer="91"/>
<label x="-53.34" y="68.58" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A4"/>
</segment>
<segment>
<wire x1="40.64" y1="71.12" x2="48.26" y2="71.12" width="0.1524" layer="91"/>
<label x="40.64" y="71.12" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A4"/>
</segment>
</net>
<net name="A5" class="0">
<segment>
<wire x1="-53.34" y1="63.5" x2="-45.72" y2="63.5" width="0.1524" layer="91"/>
<label x="-53.34" y="63.5" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A5"/>
</segment>
<segment>
<wire x1="40.64" y1="68.58" x2="48.26" y2="68.58" width="0.1524" layer="91"/>
<label x="40.64" y="68.58" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A5"/>
</segment>
</net>
<net name="A6" class="0">
<segment>
<wire x1="-53.34" y1="58.42" x2="-45.72" y2="58.42" width="0.1524" layer="91"/>
<label x="-53.34" y="58.42" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A6"/>
</segment>
<segment>
<wire x1="40.64" y1="66.04" x2="48.26" y2="66.04" width="0.1524" layer="91"/>
<label x="40.64" y="66.04" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A6"/>
</segment>
</net>
<net name="A7" class="0">
<segment>
<wire x1="-53.34" y1="53.34" x2="-45.72" y2="53.34" width="0.1524" layer="91"/>
<label x="-53.34" y="53.34" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A7"/>
</segment>
<segment>
<wire x1="40.64" y1="63.5" x2="48.26" y2="63.5" width="0.1524" layer="91"/>
<label x="40.64" y="63.5" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A7"/>
</segment>
</net>
<net name="A8" class="0">
<segment>
<wire x1="-53.34" y1="48.26" x2="-45.72" y2="48.26" width="0.1524" layer="91"/>
<label x="-53.34" y="48.26" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A8"/>
</segment>
<segment>
<wire x1="40.64" y1="60.96" x2="48.26" y2="60.96" width="0.1524" layer="91"/>
<label x="40.64" y="60.96" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A8"/>
</segment>
</net>
<net name="A9" class="0">
<segment>
<wire x1="-53.34" y1="43.18" x2="-45.72" y2="43.18" width="0.1524" layer="91"/>
<label x="-53.34" y="43.18" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A9"/>
</segment>
<segment>
<wire x1="40.64" y1="58.42" x2="48.26" y2="58.42" width="0.1524" layer="91"/>
<label x="40.64" y="58.42" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A9"/>
</segment>
</net>
<net name="A10" class="0">
<segment>
<wire x1="-53.34" y1="38.1" x2="-45.72" y2="38.1" width="0.1524" layer="91"/>
<label x="-53.34" y="38.1" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A10"/>
</segment>
<segment>
<wire x1="40.64" y1="55.88" x2="48.26" y2="55.88" width="0.1524" layer="91"/>
<label x="40.64" y="55.88" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A10"/>
</segment>
</net>
<net name="A11" class="0">
<segment>
<wire x1="-53.34" y1="33.02" x2="-45.72" y2="33.02" width="0.1524" layer="91"/>
<label x="-53.34" y="33.02" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A11"/>
</segment>
<segment>
<wire x1="40.64" y1="53.34" x2="48.26" y2="53.34" width="0.1524" layer="91"/>
<label x="40.64" y="53.34" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A11"/>
</segment>
</net>
<net name="A12" class="0">
<segment>
<wire x1="-53.34" y1="27.94" x2="-45.72" y2="27.94" width="0.1524" layer="91"/>
<label x="-53.34" y="27.94" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A12"/>
</segment>
<segment>
<wire x1="40.64" y1="50.8" x2="48.26" y2="50.8" width="0.1524" layer="91"/>
<label x="40.64" y="50.8" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A12"/>
</segment>
</net>
<net name="A13" class="0">
<segment>
<wire x1="-53.34" y1="22.86" x2="-45.72" y2="22.86" width="0.1524" layer="91"/>
<label x="-53.34" y="22.86" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A13"/>
</segment>
<segment>
<wire x1="40.64" y1="48.26" x2="48.26" y2="48.26" width="0.1524" layer="91"/>
<label x="40.64" y="48.26" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="A13"/>
</segment>
</net>
<net name="A14" class="0">
<segment>
<wire x1="-53.34" y1="17.78" x2="-45.72" y2="17.78" width="0.1524" layer="91"/>
<label x="-53.34" y="17.78" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A14"/>
</segment>
<segment>
<wire x1="2.54" y1="33.02" x2="7.62" y2="33.02" width="0.1524" layer="91"/>
<label x="2.54" y="33.02" size="1.778" layer="95"/>
<pinref part="IC741G332" gate="G$1" pin="A"/>
</segment>
</net>
<net name="A15" class="0">
<segment>
<wire x1="-53.34" y1="12.7" x2="-45.72" y2="12.7" width="0.1524" layer="91"/>
<label x="-53.34" y="12.7" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="A15"/>
</segment>
<segment>
<wire x1="2.54" y1="30.48" x2="7.62" y2="30.48" width="0.1524" layer="91"/>
<label x="2.54" y="30.48" size="1.778" layer="95"/>
<pinref part="IC741G332" gate="G$1" pin="B"/>
</segment>
</net>
<net name="MREQ" class="0">
<segment>
<wire x1="-15.24" y1="48.26" x2="-7.62" y2="48.26" width="0.1524" layer="91"/>
<label x="-10.16" y="48.26" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="MEMREQ"/>
</segment>
<segment>
<wire x1="2.54" y1="25.4" x2="7.62" y2="25.4" width="0.1524" layer="91"/>
<label x="0" y="25.4" size="1.778" layer="95"/>
<pinref part="IC741G332" gate="G$1" pin="!A!/B"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<wire x1="-15.24" y1="33.02" x2="-7.62" y2="33.02" width="0.1524" layer="91"/>
<label x="-10.16" y="33.02" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="SW1" gate="G$1" pin="C"/>
<wire x1="12.7" y1="58.42" x2="10.16" y2="58.42" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="1"/>
<wire x1="10.16" y1="58.42" x2="2.54" y2="58.42" width="0.1524" layer="91"/>
<wire x1="20.32" y1="40.64" x2="10.16" y2="40.64" width="0.1524" layer="91"/>
<wire x1="10.16" y1="40.64" x2="10.16" y2="58.42" width="0.1524" layer="91"/>
<junction x="10.16" y="58.42"/>
<label x="2.54" y="58.42" size="1.778" layer="95"/>
</segment>
</net>
<net name="VCC" class="0">
<segment>
<wire x1="-15.24" y1="43.18" x2="-7.62" y2="43.18" width="0.1524" layer="91"/>
<wire x1="-15.24" y1="38.1" x2="-7.62" y2="38.1" width="0.1524" layer="91"/>
<label x="-10.16" y="38.1" size="1.778" layer="95"/>
<wire x1="-7.62" y1="43.18" x2="-7.62" y2="38.1" width="0.1524" layer="91"/>
<wire x1="-7.62" y1="38.1" x2="0" y2="38.1" width="0.1524" layer="91"/>
<junction x="-7.62" y="38.1"/>
<pinref part="U$1" gate="G$1" pin="+5V"/>
<pinref part="U$1" gate="G$1" pin="ROMCS"/>
</segment>
<segment>
<wire x1="25.4" y1="88.9" x2="2.54" y2="88.9" width="0.1524" layer="91"/>
<label x="2.54" y="88.9" size="1.778" layer="95"/>
<pinref part="RN2" gate="G$1" pin="1"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="JP1" gate="A" pin="2"/>
<wire x1="22.86" y1="40.64" x2="25.4" y2="40.64" width="0.1524" layer="91"/>
<wire x1="25.4" y1="40.64" x2="25.4" y2="35.56" width="0.1524" layer="91"/>
<pinref part="SST28SF040" gate="G$1" pin="A18"/>
<wire x1="25.4" y1="35.56" x2="38.1" y2="35.56" width="0.1524" layer="91"/>
<pinref part="RN2" gate="G$1" pin="6"/>
<wire x1="38.1" y1="35.56" x2="48.26" y2="35.56" width="0.1524" layer="91"/>
<wire x1="35.56" y1="73.66" x2="35.56" y2="68.58" width="0.1524" layer="91"/>
<wire x1="35.56" y1="68.58" x2="38.1" y2="68.58" width="0.1524" layer="91"/>
<wire x1="38.1" y1="68.58" x2="38.1" y2="35.56" width="0.1524" layer="91"/>
<junction x="38.1" y="35.56"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="SW1" gate="G$1" pin="8"/>
<wire x1="22.86" y1="48.26" x2="27.94" y2="48.26" width="0.1524" layer="91"/>
<wire x1="27.94" y1="48.26" x2="27.94" y2="38.1" width="0.1524" layer="91"/>
<pinref part="SST28SF040" gate="G$1" pin="A17"/>
<wire x1="27.94" y1="38.1" x2="48.26" y2="38.1" width="0.1524" layer="91"/>
<wire x1="27.94" y1="73.66" x2="27.94" y2="48.26" width="0.1524" layer="91"/>
<junction x="27.94" y="48.26"/>
<pinref part="RN2" gate="G$1" pin="3"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="SW1" gate="G$1" pin="4"/>
<wire x1="22.86" y1="53.34" x2="30.48" y2="53.34" width="0.1524" layer="91"/>
<wire x1="30.48" y1="53.34" x2="30.48" y2="40.64" width="0.1524" layer="91"/>
<pinref part="SST28SF040" gate="G$1" pin="A16"/>
<wire x1="30.48" y1="40.64" x2="48.26" y2="40.64" width="0.1524" layer="91"/>
<wire x1="30.48" y1="73.66" x2="30.48" y2="53.34" width="0.1524" layer="91"/>
<junction x="30.48" y="53.34"/>
<pinref part="RN2" gate="G$1" pin="4"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="SW1" gate="G$1" pin="2"/>
<wire x1="22.86" y1="58.42" x2="33.02" y2="58.42" width="0.1524" layer="91"/>
<wire x1="33.02" y1="58.42" x2="33.02" y2="43.18" width="0.1524" layer="91"/>
<pinref part="SST28SF040" gate="G$1" pin="A15"/>
<wire x1="33.02" y1="43.18" x2="48.26" y2="43.18" width="0.1524" layer="91"/>
<wire x1="33.02" y1="73.66" x2="33.02" y2="58.42" width="0.1524" layer="91"/>
<junction x="33.02" y="58.42"/>
<pinref part="RN2" gate="G$1" pin="5"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="SW1" gate="G$1" pin="1"/>
<wire x1="22.86" y1="63.5" x2="25.4" y2="63.5" width="0.1524" layer="91"/>
<wire x1="25.4" y1="63.5" x2="35.56" y2="63.5" width="0.1524" layer="91"/>
<wire x1="35.56" y1="63.5" x2="35.56" y2="45.72" width="0.1524" layer="91"/>
<pinref part="SST28SF040" gate="G$1" pin="A14"/>
<wire x1="35.56" y1="45.72" x2="48.26" y2="45.72" width="0.1524" layer="91"/>
<pinref part="RN2" gate="G$1" pin="2"/>
<wire x1="25.4" y1="73.66" x2="25.4" y2="63.5" width="0.1524" layer="91"/>
<junction x="25.4" y="63.5"/>
</segment>
</net>
<net name="RD" class="0">
<segment>
<wire x1="40.64" y1="27.94" x2="48.26" y2="27.94" width="0.1524" layer="91"/>
<label x="40.64" y="27.94" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="!OE"/>
</segment>
<segment>
<wire x1="-15.24" y1="27.94" x2="-7.62" y2="27.94" width="0.1524" layer="91"/>
<label x="-10.16" y="27.94" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="RD"/>
</segment>
</net>
<net name="WR" class="0">
<segment>
<wire x1="40.64" y1="25.4" x2="48.26" y2="25.4" width="0.1524" layer="91"/>
<label x="40.64" y="25.4" size="1.778" layer="95"/>
<pinref part="SST28SF040" gate="G$1" pin="!WE"/>
</segment>
<segment>
<wire x1="-15.24" y1="22.86" x2="-7.62" y2="22.86" width="0.1524" layer="91"/>
<label x="-10.16" y="22.86" size="1.778" layer="95"/>
<pinref part="U$1" gate="G$1" pin="WR"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
