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
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="pinhead">
<description>&lt;b&gt;Pin Header Connectors&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="1X14">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="13.335" y1="1.27" x2="14.605" y2="1.27" width="0.1524" layer="21"/>
<wire x1="14.605" y1="1.27" x2="15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="15.24" y1="0.635" x2="15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-0.635" x2="14.605" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="10.16" y1="0.635" x2="10.795" y2="1.27" width="0.1524" layer="21"/>
<wire x1="10.795" y1="1.27" x2="12.065" y2="1.27" width="0.1524" layer="21"/>
<wire x1="12.065" y1="1.27" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="0.635" x2="12.7" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-0.635" x2="12.065" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="12.065" y1="-1.27" x2="10.795" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="10.795" y1="-1.27" x2="10.16" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="13.335" y1="1.27" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-0.635" x2="13.335" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="14.605" y1="-1.27" x2="13.335" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="1.27" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-0.635" x2="6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="8.255" y2="1.27" width="0.1524" layer="21"/>
<wire x1="8.255" y1="1.27" x2="9.525" y2="1.27" width="0.1524" layer="21"/>
<wire x1="9.525" y1="1.27" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="0.635" x2="10.16" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-0.635" x2="9.525" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="9.525" y1="-1.27" x2="8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-1.27" x2="7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="1.27" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-0.635" x2="4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-1.27" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-1.27" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-0.635" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-1.27" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="1.27" x2="-3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-1.27" x2="-4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="-1.27" x2="-5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="1.27" x2="-8.255" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="1.27" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-0.635" x2="-8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="1.27" x2="-5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="1.27" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-0.635" x2="-5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-1.27" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="-1.27" x2="-7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="0.635" x2="-12.065" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="1.27" x2="-10.795" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="1.27" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="0.635" x2="-10.16" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-0.635" x2="-10.795" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="-1.27" x2="-12.065" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="-1.27" x2="-12.7" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="1.27" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-0.635" x2="-9.525" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="-1.27" x2="-9.525" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-17.145" y1="1.27" x2="-15.875" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-15.875" y1="1.27" x2="-15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="0.635" x2="-15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="-0.635" x2="-15.875" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="0.635" x2="-14.605" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-14.605" y1="1.27" x2="-13.335" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="1.27" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="0.635" x2="-12.7" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-0.635" x2="-13.335" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-1.27" x2="-14.605" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-14.605" y1="-1.27" x2="-15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="0.635" x2="-17.78" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-17.145" y1="1.27" x2="-17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="-0.635" x2="-17.145" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-15.875" y1="-1.27" x2="-17.145" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="15.24" y1="0.635" x2="15.875" y2="1.27" width="0.1524" layer="21"/>
<wire x1="15.875" y1="1.27" x2="17.145" y2="1.27" width="0.1524" layer="21"/>
<wire x1="17.145" y1="1.27" x2="17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="17.78" y1="0.635" x2="17.78" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="17.78" y1="-0.635" x2="17.145" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="17.145" y1="-1.27" x2="15.875" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="15.875" y1="-1.27" x2="15.24" y2="-0.635" width="0.1524" layer="21"/>
<pad name="1" x="-16.51" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="2" x="-13.97" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="3" x="-11.43" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="4" x="-8.89" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="5" x="-6.35" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="6" x="-3.81" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="7" x="-1.27" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="8" x="1.27" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="9" x="3.81" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="10" x="6.35" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="11" x="8.89" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="12" x="11.43" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="13" x="13.97" y="0" drill="1.016" shape="octagon" rot="R90"/>
<pad name="14" x="16.51" y="0" drill="1.016" shape="octagon" rot="R90"/>
<text x="-17.8562" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-17.78" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="13.716" y1="-0.254" x2="14.224" y2="0.254" layer="51"/>
<rectangle x1="11.176" y1="-0.254" x2="11.684" y2="0.254" layer="51"/>
<rectangle x1="8.636" y1="-0.254" x2="9.144" y2="0.254" layer="51"/>
<rectangle x1="6.096" y1="-0.254" x2="6.604" y2="0.254" layer="51"/>
<rectangle x1="3.556" y1="-0.254" x2="4.064" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="-4.064" y1="-0.254" x2="-3.556" y2="0.254" layer="51"/>
<rectangle x1="-6.604" y1="-0.254" x2="-6.096" y2="0.254" layer="51"/>
<rectangle x1="-9.144" y1="-0.254" x2="-8.636" y2="0.254" layer="51"/>
<rectangle x1="-11.684" y1="-0.254" x2="-11.176" y2="0.254" layer="51"/>
<rectangle x1="-14.224" y1="-0.254" x2="-13.716" y2="0.254" layer="51"/>
<rectangle x1="-16.764" y1="-0.254" x2="-16.256" y2="0.254" layer="51"/>
<rectangle x1="16.256" y1="-0.254" x2="16.764" y2="0.254" layer="51"/>
</package>
<package name="1X14/90">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-17.78" y1="-1.905" x2="-15.24" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="-1.905" x2="-15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="0.635" x2="-17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="0.635" x2="-17.78" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-16.51" y1="6.985" x2="-16.51" y2="1.27" width="0.762" layer="21"/>
<wire x1="-15.24" y1="-1.905" x2="-12.7" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-1.905" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="0.635" x2="-15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-13.97" y1="6.985" x2="-13.97" y2="1.27" width="0.762" layer="21"/>
<wire x1="-12.7" y1="-1.905" x2="-10.16" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-1.905" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="0.635" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-11.43" y1="6.985" x2="-11.43" y2="1.27" width="0.762" layer="21"/>
<wire x1="-10.16" y1="-1.905" x2="-7.62" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-1.905" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-8.89" y1="6.985" x2="-8.89" y2="1.27" width="0.762" layer="21"/>
<wire x1="-7.62" y1="-1.905" x2="-5.08" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-6.35" y1="6.985" x2="-6.35" y2="1.27" width="0.762" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-1.905" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="6.985" x2="-3.81" y2="1.27" width="0.762" layer="21"/>
<wire x1="-2.54" y1="-1.905" x2="0" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="0" y1="-1.905" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="6.985" x2="-1.27" y2="1.27" width="0.762" layer="21"/>
<wire x1="0" y1="-1.905" x2="2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="6.985" x2="1.27" y2="1.27" width="0.762" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="5.08" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-1.905" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="3.81" y1="6.985" x2="3.81" y2="1.27" width="0.762" layer="21"/>
<wire x1="5.08" y1="-1.905" x2="7.62" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-1.905" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="6.35" y1="6.985" x2="6.35" y2="1.27" width="0.762" layer="21"/>
<wire x1="7.62" y1="-1.905" x2="10.16" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-1.905" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="0.635" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="8.89" y1="6.985" x2="8.89" y2="1.27" width="0.762" layer="21"/>
<wire x1="10.16" y1="-1.905" x2="12.7" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-1.905" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="0.635" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="11.43" y1="6.985" x2="11.43" y2="1.27" width="0.762" layer="21"/>
<wire x1="12.7" y1="-1.905" x2="15.24" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-1.905" x2="15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="15.24" y1="0.635" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="13.97" y1="6.985" x2="13.97" y2="1.27" width="0.762" layer="21"/>
<wire x1="15.24" y1="-1.905" x2="17.78" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="17.78" y1="-1.905" x2="17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="17.78" y1="0.635" x2="15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="16.51" y1="6.985" x2="16.51" y2="1.27" width="0.762" layer="21"/>
<pad name="1" x="-16.51" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="-13.97" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="-11.43" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="4" x="-8.89" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="5" x="-6.35" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="6" x="-3.81" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="7" x="-1.27" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="8" x="1.27" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="9" x="3.81" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="10" x="6.35" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="11" x="8.89" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="12" x="11.43" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="13" x="13.97" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="14" x="16.51" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<text x="-18.415" y="-3.81" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="19.685" y="-4.445" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
<rectangle x1="-16.891" y1="0.635" x2="-16.129" y2="1.143" layer="21"/>
<rectangle x1="-14.351" y1="0.635" x2="-13.589" y2="1.143" layer="21"/>
<rectangle x1="-11.811" y1="0.635" x2="-11.049" y2="1.143" layer="21"/>
<rectangle x1="-9.271" y1="0.635" x2="-8.509" y2="1.143" layer="21"/>
<rectangle x1="-6.731" y1="0.635" x2="-5.969" y2="1.143" layer="21"/>
<rectangle x1="-4.191" y1="0.635" x2="-3.429" y2="1.143" layer="21"/>
<rectangle x1="-1.651" y1="0.635" x2="-0.889" y2="1.143" layer="21"/>
<rectangle x1="0.889" y1="0.635" x2="1.651" y2="1.143" layer="21"/>
<rectangle x1="3.429" y1="0.635" x2="4.191" y2="1.143" layer="21"/>
<rectangle x1="5.969" y1="0.635" x2="6.731" y2="1.143" layer="21"/>
<rectangle x1="8.509" y1="0.635" x2="9.271" y2="1.143" layer="21"/>
<rectangle x1="11.049" y1="0.635" x2="11.811" y2="1.143" layer="21"/>
<rectangle x1="13.589" y1="0.635" x2="14.351" y2="1.143" layer="21"/>
<rectangle x1="16.129" y1="0.635" x2="16.891" y2="1.143" layer="21"/>
<rectangle x1="-16.891" y1="-2.921" x2="-16.129" y2="-1.905" layer="21"/>
<rectangle x1="-14.351" y1="-2.921" x2="-13.589" y2="-1.905" layer="21"/>
<rectangle x1="-11.811" y1="-2.921" x2="-11.049" y2="-1.905" layer="21"/>
<rectangle x1="-9.271" y1="-2.921" x2="-8.509" y2="-1.905" layer="21"/>
<rectangle x1="-6.731" y1="-2.921" x2="-5.969" y2="-1.905" layer="21"/>
<rectangle x1="-4.191" y1="-2.921" x2="-3.429" y2="-1.905" layer="21"/>
<rectangle x1="-1.651" y1="-2.921" x2="-0.889" y2="-1.905" layer="21"/>
<rectangle x1="0.889" y1="-2.921" x2="1.651" y2="-1.905" layer="21"/>
<rectangle x1="3.429" y1="-2.921" x2="4.191" y2="-1.905" layer="21"/>
<rectangle x1="5.969" y1="-2.921" x2="6.731" y2="-1.905" layer="21"/>
<rectangle x1="8.509" y1="-2.921" x2="9.271" y2="-1.905" layer="21"/>
<rectangle x1="11.049" y1="-2.921" x2="11.811" y2="-1.905" layer="21"/>
<rectangle x1="13.589" y1="-2.921" x2="14.351" y2="-1.905" layer="21"/>
<rectangle x1="16.129" y1="-2.921" x2="16.891" y2="-1.905" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="PINHD14">
<wire x1="-6.35" y1="-20.32" x2="1.27" y2="-20.32" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-20.32" x2="1.27" y2="17.78" width="0.4064" layer="94"/>
<wire x1="1.27" y1="17.78" x2="-6.35" y2="17.78" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="17.78" x2="-6.35" y2="-20.32" width="0.4064" layer="94"/>
<text x="-6.35" y="18.415" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-22.86" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="15.24" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="12.7" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="3" x="-2.54" y="10.16" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="4" x="-2.54" y="7.62" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="5" x="-2.54" y="5.08" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="6" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="7" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="8" x="-2.54" y="-2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="9" x="-2.54" y="-5.08" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="10" x="-2.54" y="-7.62" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="11" x="-2.54" y="-10.16" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="12" x="-2.54" y="-12.7" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="13" x="-2.54" y="-15.24" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="14" x="-2.54" y="-17.78" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="PINHD-1X14" prefix="JP" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="A" symbol="PINHD14" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X14">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="10" pad="10"/>
<connect gate="A" pin="11" pad="11"/>
<connect gate="A" pin="12" pad="12"/>
<connect gate="A" pin="13" pad="13"/>
<connect gate="A" pin="14" pad="14"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
<connect gate="A" pin="4" pad="4"/>
<connect gate="A" pin="5" pad="5"/>
<connect gate="A" pin="6" pad="6"/>
<connect gate="A" pin="7" pad="7"/>
<connect gate="A" pin="8" pad="8"/>
<connect gate="A" pin="9" pad="9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="/90" package="1X14/90">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="10" pad="10"/>
<connect gate="A" pin="11" pad="11"/>
<connect gate="A" pin="12" pad="12"/>
<connect gate="A" pin="13" pad="13"/>
<connect gate="A" pin="14" pad="14"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
<connect gate="A" pin="4" pad="4"/>
<connect gate="A" pin="5" pad="5"/>
<connect gate="A" pin="6" pad="6"/>
<connect gate="A" pin="7" pad="7"/>
<connect gate="A" pin="8" pad="8"/>
<connect gate="A" pin="9" pad="9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply1">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
 GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
 Please keep in mind, that these devices are necessary for the
 automatic wiring of the supply signals.&lt;p&gt;
 The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
 In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
 &lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="GND">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
<symbol name="VCC">
<wire x1="1.27" y1="-1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="VCC" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" prefix="GND">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="VCC" prefix="P+">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="VCC" symbol="VCC" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="zx_bus_connector_lado_spectrum">
<packages>
<package name="CONECTOR_LADO_SPECTRUM">
<wire x1="6.604" y1="-68.58" x2="6.604" y2="-8.89" width="0" layer="20"/>
<wire x1="6.604" y1="-8.89" x2="-1.27" y2="-8.89" width="0" layer="20"/>
<wire x1="-1.27" y1="-8.89" x2="-1.27" y2="-6.35" width="0" layer="20"/>
<wire x1="-1.27" y1="-6.35" x2="6.604" y2="-6.35" width="0" layer="20"/>
<wire x1="6.604" y1="-6.35" x2="6.604" y2="5.08" width="0" layer="20"/>
<smd name="P$1" x="2.54" y="2.54" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$2" x="2.54" y="0" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$3" x="2.54" y="-2.54" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$4" x="2.54" y="-5.08" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$5" x="2.54" y="-10.16" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$6" x="2.54" y="-12.7" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$7" x="2.54" y="-15.24" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$8" x="2.54" y="-17.78" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$9" x="2.54" y="-20.32" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$10" x="2.54" y="-22.86" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$11" x="2.54" y="-25.4" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$12" x="2.54" y="-27.94" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$13" x="2.54" y="-30.48" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$14" x="2.54" y="-33.02" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$15" x="2.54" y="-35.56" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$16" x="2.54" y="-38.1" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$17" x="2.54" y="-40.64" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$18" x="2.54" y="-43.18" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$19" x="2.54" y="-45.72" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$20" x="2.54" y="-48.26" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$21" x="2.54" y="-50.8" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$22" x="2.54" y="-53.34" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$23" x="2.54" y="-55.88" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$24" x="2.54" y="-58.42" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$25" x="2.54" y="-60.96" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$26" x="2.54" y="-63.5" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$27" x="2.54" y="-66.04" dx="7.62" dy="1.524" layer="1"/>
<smd name="P$28" x="2.54" y="2.54" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$29" x="2.54" y="0" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$30" x="2.54" y="-2.54" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$31" x="2.54" y="-5.08" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$32" x="2.54" y="-10.16" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$33" x="2.54" y="-12.7" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$34" x="2.54" y="-15.24" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$35" x="2.54" y="-17.78" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$36" x="2.54" y="-20.32" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$37" x="2.54" y="-22.86" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$38" x="2.54" y="-25.4" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$39" x="2.54" y="-27.94" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$40" x="2.54" y="-30.48" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$41" x="2.54" y="-33.02" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$42" x="2.54" y="-35.56" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$43" x="2.54" y="-38.1" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$44" x="2.54" y="-40.64" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$45" x="2.54" y="-43.18" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$46" x="2.54" y="-45.72" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$47" x="2.54" y="-48.26" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$48" x="2.54" y="-50.8" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$49" x="2.54" y="-53.34" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$50" x="2.54" y="-55.88" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$51" x="2.54" y="-58.42" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$52" x="2.54" y="-60.96" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$53" x="2.54" y="-63.5" dx="7.62" dy="1.524" layer="16"/>
<smd name="P$54" x="2.54" y="-66.04" dx="7.62" dy="1.524" layer="16"/>
</package>
</packages>
<symbols>
<symbol name="CONECTOR_BUS_TRASERO_SPECTRUM">
<wire x1="15.24" y1="35.56" x2="15.24" y2="-38.1" width="0.254" layer="94"/>
<wire x1="15.24" y1="-38.1" x2="-12.7" y2="-38.1" width="0.254" layer="94"/>
<wire x1="-12.7" y1="-38.1" x2="-12.7" y2="35.56" width="0.254" layer="94"/>
<wire x1="-12.7" y1="35.56" x2="15.24" y2="35.56" width="0.254" layer="94"/>
<text x="10.16" y="36.322" size="1.27" layer="94">CMP</text>
<text x="-12.7" y="36.322" size="1.27" layer="94">SLD</text>
<pin name="A15" x="20.32" y="33.02" length="middle" rot="R180"/>
<pin name="A13" x="20.32" y="30.48" length="middle" rot="R180"/>
<pin name="D7" x="20.32" y="27.94" length="middle" rot="R180"/>
<pin name="ROM1OE" x="20.32" y="25.4" length="middle" rot="R180"/>
<pin name="D0" x="20.32" y="20.32" length="middle" rot="R180"/>
<pin name="D1" x="20.32" y="17.78" length="middle" rot="R180"/>
<pin name="D2" x="20.32" y="15.24" length="middle" rot="R180"/>
<pin name="D6" x="20.32" y="12.7" length="middle" rot="R180"/>
<pin name="D5" x="20.32" y="10.16" length="middle" rot="R180"/>
<pin name="D3" x="20.32" y="7.62" length="middle" rot="R180"/>
<pin name="D4" x="20.32" y="5.08" length="middle" rot="R180"/>
<pin name="INT" x="20.32" y="2.54" length="middle" rot="R180"/>
<pin name="NMI" x="20.32" y="0" length="middle" rot="R180"/>
<pin name="HALT" x="20.32" y="-2.54" length="middle" rot="R180"/>
<pin name="MREQ" x="20.32" y="-5.08" length="middle" rot="R180"/>
<pin name="IORQ" x="20.32" y="-7.62" length="middle" rot="R180"/>
<pin name="RD" x="20.32" y="-10.16" length="middle" rot="R180"/>
<pin name="WR" x="20.32" y="-12.7" length="middle" rot="R180"/>
<pin name="-5V" x="20.32" y="-15.24" length="middle" rot="R180"/>
<pin name="WAIT" x="20.32" y="-17.78" length="middle" rot="R180"/>
<pin name="+12V" x="20.32" y="-20.32" length="middle" rot="R180"/>
<pin name="12VAC/-12V" x="20.32" y="-22.86" length="middle" rot="R180"/>
<pin name="M1" x="20.32" y="-25.4" length="middle" rot="R180"/>
<pin name="RFSH" x="20.32" y="-27.94" length="middle" rot="R180"/>
<pin name="A8" x="20.32" y="-30.48" length="middle" rot="R180"/>
<pin name="A10" x="20.32" y="-33.02" length="middle" rot="R180"/>
<pin name="RESET2" x="20.32" y="-35.56" length="middle" rot="R180"/>
<pin name="A14" x="-17.78" y="33.02" length="middle"/>
<pin name="A12" x="-17.78" y="30.48" length="middle"/>
<pin name="+5V" x="-17.78" y="27.94" length="middle"/>
<pin name="+9V" x="-17.78" y="25.4" length="middle"/>
<pin name="GND1" x="-17.78" y="20.32" length="middle"/>
<pin name="GND2" x="-17.78" y="17.78" length="middle"/>
<pin name="CLK" x="-17.78" y="15.24" length="middle"/>
<pin name="A0" x="-17.78" y="12.7" length="middle"/>
<pin name="A1" x="-17.78" y="10.16" length="middle"/>
<pin name="A2" x="-17.78" y="7.62" length="middle"/>
<pin name="A3" x="-17.78" y="5.08" length="middle"/>
<pin name="IORQGE" x="-17.78" y="2.54" length="middle"/>
<pin name="GND" x="-17.78" y="0" length="middle"/>
<pin name="VIDEO/ROM2OE" x="-17.78" y="-2.54" length="middle"/>
<pin name="Y/DISKRD" x="-17.78" y="-5.08" length="middle"/>
<pin name="V/DISKWR" x="-17.78" y="-7.62" length="middle"/>
<pin name="U/MOTORON" x="-17.78" y="-10.16" length="middle"/>
<pin name="BUSRQ" x="-17.78" y="-12.7" length="middle"/>
<pin name="RESET" x="-17.78" y="-15.24" length="middle"/>
<pin name="A7" x="-17.78" y="-17.78" length="middle"/>
<pin name="A6" x="-17.78" y="-20.32" length="middle"/>
<pin name="A5" x="-17.78" y="-22.86" length="middle"/>
<pin name="A4" x="-17.78" y="-25.4" length="middle"/>
<pin name="ROMCS" x="-17.78" y="-27.94" length="middle"/>
<pin name="BUSACK" x="-17.78" y="-30.48" length="middle"/>
<pin name="A9" x="-17.78" y="-33.02" length="middle"/>
<pin name="A11" x="-17.78" y="-35.56" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="CONECTOR_EDGE_LADO_SPECTRUM">
<gates>
<gate name="G$1" symbol="CONECTOR_BUS_TRASERO_SPECTRUM" x="0" y="0"/>
</gates>
<devices>
<device name="" package="CONECTOR_LADO_SPECTRUM">
<connects>
<connect gate="G$1" pin="+12V" pad="P$21"/>
<connect gate="G$1" pin="+5V" pad="P$30"/>
<connect gate="G$1" pin="+9V" pad="P$31"/>
<connect gate="G$1" pin="-5V" pad="P$19"/>
<connect gate="G$1" pin="12VAC/-12V" pad="P$22"/>
<connect gate="G$1" pin="A0" pad="P$35"/>
<connect gate="G$1" pin="A1" pad="P$36"/>
<connect gate="G$1" pin="A10" pad="P$26"/>
<connect gate="G$1" pin="A11" pad="P$54"/>
<connect gate="G$1" pin="A12" pad="P$29"/>
<connect gate="G$1" pin="A13" pad="P$2"/>
<connect gate="G$1" pin="A14" pad="P$28"/>
<connect gate="G$1" pin="A15" pad="P$1"/>
<connect gate="G$1" pin="A2" pad="P$37"/>
<connect gate="G$1" pin="A3" pad="P$38"/>
<connect gate="G$1" pin="A4" pad="P$50"/>
<connect gate="G$1" pin="A5" pad="P$49"/>
<connect gate="G$1" pin="A6" pad="P$48"/>
<connect gate="G$1" pin="A7" pad="P$47"/>
<connect gate="G$1" pin="A8" pad="P$25"/>
<connect gate="G$1" pin="A9" pad="P$53"/>
<connect gate="G$1" pin="BUSACK" pad="P$52"/>
<connect gate="G$1" pin="BUSRQ" pad="P$45"/>
<connect gate="G$1" pin="CLK" pad="P$34"/>
<connect gate="G$1" pin="D0" pad="P$5"/>
<connect gate="G$1" pin="D1" pad="P$6"/>
<connect gate="G$1" pin="D2" pad="P$7"/>
<connect gate="G$1" pin="D3" pad="P$10"/>
<connect gate="G$1" pin="D4" pad="P$11"/>
<connect gate="G$1" pin="D5" pad="P$9"/>
<connect gate="G$1" pin="D6" pad="P$8"/>
<connect gate="G$1" pin="D7" pad="P$3"/>
<connect gate="G$1" pin="GND" pad="P$40"/>
<connect gate="G$1" pin="GND1" pad="P$32"/>
<connect gate="G$1" pin="GND2" pad="P$33"/>
<connect gate="G$1" pin="HALT" pad="P$14"/>
<connect gate="G$1" pin="INT" pad="P$12"/>
<connect gate="G$1" pin="IORQ" pad="P$16"/>
<connect gate="G$1" pin="IORQGE" pad="P$39"/>
<connect gate="G$1" pin="M1" pad="P$23"/>
<connect gate="G$1" pin="MREQ" pad="P$15"/>
<connect gate="G$1" pin="NMI" pad="P$13"/>
<connect gate="G$1" pin="RD" pad="P$17"/>
<connect gate="G$1" pin="RESET" pad="P$46"/>
<connect gate="G$1" pin="RESET2" pad="P$27"/>
<connect gate="G$1" pin="RFSH" pad="P$24"/>
<connect gate="G$1" pin="ROM1OE" pad="P$4"/>
<connect gate="G$1" pin="ROMCS" pad="P$51"/>
<connect gate="G$1" pin="U/MOTORON" pad="P$44"/>
<connect gate="G$1" pin="V/DISKWR" pad="P$43"/>
<connect gate="G$1" pin="VIDEO/ROM2OE" pad="P$41"/>
<connect gate="G$1" pin="WAIT" pad="P$20"/>
<connect gate="G$1" pin="WR" pad="P$18"/>
<connect gate="G$1" pin="Y/DISKRD" pad="P$42"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="74xx-eu">
<description>&lt;b&gt;TTL Devices, 74xx Series with European Symbols&lt;/b&gt;&lt;p&gt;
Based on the following sources:
&lt;ul&gt;
&lt;li&gt;Texas Instruments &lt;i&gt;TTL Data Book&lt;/i&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;Volume 1, 1996.
&lt;li&gt;TTL Data Book, Volume 2 , 1993
&lt;li&gt;National Seminconductor Databook 1990, ALS/LS Logic
&lt;li&gt;ttl 74er digital data dictionary, ECA Electronic + Acustic GmbH, ISBN 3-88109-032-0
&lt;li&gt;http://icmaster.com/ViewCompare.asp
&lt;/ul&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="DIL20">
<description>&lt;b&gt;Dual In Line Package&lt;/b&gt;</description>
<wire x1="12.7" y1="2.921" x2="-12.7" y2="2.921" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-2.921" x2="12.7" y2="-2.921" width="0.1524" layer="21"/>
<wire x1="12.7" y1="2.921" x2="12.7" y2="-2.921" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="2.921" x2="-12.7" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-2.921" x2="-12.7" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="1.016" x2="-12.7" y2="-1.016" width="0.1524" layer="21" curve="-180"/>
<pad name="1" x="-11.43" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="2" x="-8.89" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="7" x="3.81" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="8" x="6.35" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="3" x="-6.35" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="4" x="-3.81" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="6" x="1.27" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="5" x="-1.27" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="9" x="8.89" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="10" x="11.43" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="11" x="11.43" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="12" x="8.89" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="13" x="6.35" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="14" x="3.81" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="15" x="1.27" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="16" x="-1.27" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="17" x="-3.81" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="18" x="-6.35" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="19" x="-8.89" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="20" x="-11.43" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<text x="-13.081" y="-3.048" size="1.27" layer="25" rot="R90">&gt;NAME</text>
<text x="-9.779" y="-0.381" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="SO20W">
<description>&lt;b&gt;Wide Small Outline package&lt;/b&gt; 300 mil</description>
<wire x1="6.1214" y1="3.7338" x2="-6.1214" y2="3.7338" width="0.1524" layer="51"/>
<wire x1="6.1214" y1="-3.7338" x2="6.5024" y2="-3.3528" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.5024" y1="3.3528" x2="-6.1214" y2="3.7338" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.1214" y1="3.7338" x2="6.5024" y2="3.3528" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.5024" y1="-3.3528" x2="-6.1214" y2="-3.7338" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.1214" y1="-3.7338" x2="6.1214" y2="-3.7338" width="0.1524" layer="51"/>
<wire x1="6.5024" y1="-3.3528" x2="6.5024" y2="3.3528" width="0.1524" layer="21"/>
<wire x1="-6.5024" y1="3.3528" x2="-6.5024" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-6.5024" y1="1.27" x2="-6.5024" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-6.5024" y1="-1.27" x2="-6.5024" y2="-3.3528" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="-3.3782" x2="6.477" y2="-3.3782" width="0.0508" layer="21"/>
<wire x1="-6.5024" y1="1.27" x2="-6.5024" y2="-1.27" width="0.1524" layer="21" curve="-180"/>
<smd name="1" x="-5.715" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="2" x="-4.445" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="3" x="-3.175" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="4" x="-1.905" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="5" x="-0.635" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="6" x="0.635" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="7" x="1.905" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="8" x="3.175" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="13" x="3.175" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="14" x="1.905" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="15" x="0.635" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="16" x="-0.635" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="17" x="-1.905" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="18" x="-3.175" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="19" x="-4.445" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="20" x="-5.715" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="9" x="4.445" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="10" x="5.715" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="12" x="4.445" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="11" x="5.715" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<text x="-3.81" y="-1.778" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-6.858" y="-3.175" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<rectangle x1="-5.969" y1="-3.8608" x2="-5.461" y2="-3.7338" layer="51"/>
<rectangle x1="-5.969" y1="-5.334" x2="-5.461" y2="-3.8608" layer="51"/>
<rectangle x1="-4.699" y1="-3.8608" x2="-4.191" y2="-3.7338" layer="51"/>
<rectangle x1="-4.699" y1="-5.334" x2="-4.191" y2="-3.8608" layer="51"/>
<rectangle x1="-3.429" y1="-3.8608" x2="-2.921" y2="-3.7338" layer="51"/>
<rectangle x1="-3.429" y1="-5.334" x2="-2.921" y2="-3.8608" layer="51"/>
<rectangle x1="-2.159" y1="-3.8608" x2="-1.651" y2="-3.7338" layer="51"/>
<rectangle x1="-2.159" y1="-5.334" x2="-1.651" y2="-3.8608" layer="51"/>
<rectangle x1="-0.889" y1="-5.334" x2="-0.381" y2="-3.8608" layer="51"/>
<rectangle x1="-0.889" y1="-3.8608" x2="-0.381" y2="-3.7338" layer="51"/>
<rectangle x1="0.381" y1="-3.8608" x2="0.889" y2="-3.7338" layer="51"/>
<rectangle x1="0.381" y1="-5.334" x2="0.889" y2="-3.8608" layer="51"/>
<rectangle x1="1.651" y1="-3.8608" x2="2.159" y2="-3.7338" layer="51"/>
<rectangle x1="1.651" y1="-5.334" x2="2.159" y2="-3.8608" layer="51"/>
<rectangle x1="2.921" y1="-3.8608" x2="3.429" y2="-3.7338" layer="51"/>
<rectangle x1="2.921" y1="-5.334" x2="3.429" y2="-3.8608" layer="51"/>
<rectangle x1="-5.969" y1="3.8608" x2="-5.461" y2="5.334" layer="51"/>
<rectangle x1="-5.969" y1="3.7338" x2="-5.461" y2="3.8608" layer="51"/>
<rectangle x1="-4.699" y1="3.7338" x2="-4.191" y2="3.8608" layer="51"/>
<rectangle x1="-4.699" y1="3.8608" x2="-4.191" y2="5.334" layer="51"/>
<rectangle x1="-3.429" y1="3.7338" x2="-2.921" y2="3.8608" layer="51"/>
<rectangle x1="-3.429" y1="3.8608" x2="-2.921" y2="5.334" layer="51"/>
<rectangle x1="-2.159" y1="3.7338" x2="-1.651" y2="3.8608" layer="51"/>
<rectangle x1="-2.159" y1="3.8608" x2="-1.651" y2="5.334" layer="51"/>
<rectangle x1="-0.889" y1="3.7338" x2="-0.381" y2="3.8608" layer="51"/>
<rectangle x1="-0.889" y1="3.8608" x2="-0.381" y2="5.334" layer="51"/>
<rectangle x1="0.381" y1="3.7338" x2="0.889" y2="3.8608" layer="51"/>
<rectangle x1="0.381" y1="3.8608" x2="0.889" y2="5.334" layer="51"/>
<rectangle x1="1.651" y1="3.7338" x2="2.159" y2="3.8608" layer="51"/>
<rectangle x1="1.651" y1="3.8608" x2="2.159" y2="5.334" layer="51"/>
<rectangle x1="2.921" y1="3.7338" x2="3.429" y2="3.8608" layer="51"/>
<rectangle x1="2.921" y1="3.8608" x2="3.429" y2="5.334" layer="51"/>
<rectangle x1="4.191" y1="3.7338" x2="4.699" y2="3.8608" layer="51"/>
<rectangle x1="5.461" y1="3.7338" x2="5.969" y2="3.8608" layer="51"/>
<rectangle x1="4.191" y1="3.8608" x2="4.699" y2="5.334" layer="51"/>
<rectangle x1="5.461" y1="3.8608" x2="5.969" y2="5.334" layer="51"/>
<rectangle x1="4.191" y1="-3.8608" x2="4.699" y2="-3.7338" layer="51"/>
<rectangle x1="5.461" y1="-3.8608" x2="5.969" y2="-3.7338" layer="51"/>
<rectangle x1="4.191" y1="-5.334" x2="4.699" y2="-3.8608" layer="51"/>
<rectangle x1="5.461" y1="-5.334" x2="5.969" y2="-3.8608" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="74574">
<wire x1="-7.62" y1="-15.24" x2="7.62" y2="-15.24" width="0.4064" layer="94"/>
<wire x1="7.62" y1="-15.24" x2="7.62" y2="15.24" width="0.4064" layer="94"/>
<wire x1="7.62" y1="15.24" x2="-7.62" y2="15.24" width="0.4064" layer="94"/>
<wire x1="-7.62" y1="15.24" x2="-7.62" y2="-15.24" width="0.4064" layer="94"/>
<text x="-7.62" y="15.875" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="-7.62" y="-17.78" size="1.778" layer="96">&gt;VALUE</text>
<pin name="OC" x="-12.7" y="-12.7" length="middle" direction="in" function="dot"/>
<pin name="1D" x="-12.7" y="12.7" length="middle" direction="in"/>
<pin name="2D" x="-12.7" y="10.16" length="middle" direction="in"/>
<pin name="3D" x="-12.7" y="7.62" length="middle" direction="in"/>
<pin name="4D" x="-12.7" y="5.08" length="middle" direction="in"/>
<pin name="5D" x="-12.7" y="2.54" length="middle" direction="in"/>
<pin name="6D" x="-12.7" y="0" length="middle" direction="in"/>
<pin name="7D" x="-12.7" y="-2.54" length="middle" direction="in"/>
<pin name="8D" x="-12.7" y="-5.08" length="middle" direction="in"/>
<pin name="CLK" x="-12.7" y="-10.16" length="middle" direction="in" function="clk"/>
<pin name="8Q" x="12.7" y="-5.08" length="middle" direction="hiz" rot="R180"/>
<pin name="7Q" x="12.7" y="-2.54" length="middle" direction="hiz" rot="R180"/>
<pin name="6Q" x="12.7" y="0" length="middle" direction="hiz" rot="R180"/>
<pin name="5Q" x="12.7" y="2.54" length="middle" direction="hiz" rot="R180"/>
<pin name="4Q" x="12.7" y="5.08" length="middle" direction="hiz" rot="R180"/>
<pin name="3Q" x="12.7" y="7.62" length="middle" direction="hiz" rot="R180"/>
<pin name="2Q" x="12.7" y="10.16" length="middle" direction="hiz" rot="R180"/>
<pin name="1Q" x="12.7" y="12.7" length="middle" direction="hiz" rot="R180"/>
</symbol>
<symbol name="PWRN">
<text x="-0.635" y="-0.635" size="1.778" layer="95">&gt;NAME</text>
<text x="1.905" y="-5.842" size="1.27" layer="95" rot="R90">GND</text>
<text x="1.905" y="2.54" size="1.27" layer="95" rot="R90">VCC</text>
<pin name="GND" x="0" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="VCC" x="0" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="74*574" prefix="IC">
<description>8-bit D type &lt;b&gt;FLIP FLOP&lt;/b&gt; bus driver</description>
<gates>
<gate name="A" symbol="74574" x="20.32" y="0"/>
<gate name="P" symbol="PWRN" x="-5.08" y="0" addlevel="request"/>
</gates>
<devices>
<device name="N" package="DIL20">
<connects>
<connect gate="A" pin="1D" pad="2"/>
<connect gate="A" pin="1Q" pad="19"/>
<connect gate="A" pin="2D" pad="3"/>
<connect gate="A" pin="2Q" pad="18"/>
<connect gate="A" pin="3D" pad="4"/>
<connect gate="A" pin="3Q" pad="17"/>
<connect gate="A" pin="4D" pad="5"/>
<connect gate="A" pin="4Q" pad="16"/>
<connect gate="A" pin="5D" pad="6"/>
<connect gate="A" pin="5Q" pad="15"/>
<connect gate="A" pin="6D" pad="7"/>
<connect gate="A" pin="6Q" pad="14"/>
<connect gate="A" pin="7D" pad="8"/>
<connect gate="A" pin="7Q" pad="13"/>
<connect gate="A" pin="8D" pad="9"/>
<connect gate="A" pin="8Q" pad="12"/>
<connect gate="A" pin="CLK" pad="11"/>
<connect gate="A" pin="OC" pad="1"/>
<connect gate="P" pin="GND" pad="10"/>
<connect gate="P" pin="VCC" pad="20"/>
</connects>
<technologies>
<technology name="AC"/>
<technology name="ACT"/>
<technology name="AS"/>
<technology name="HC"/>
<technology name="HCT"/>
</technologies>
</device>
<device name="D" package="SO20W">
<connects>
<connect gate="A" pin="1D" pad="2"/>
<connect gate="A" pin="1Q" pad="19"/>
<connect gate="A" pin="2D" pad="3"/>
<connect gate="A" pin="2Q" pad="18"/>
<connect gate="A" pin="3D" pad="4"/>
<connect gate="A" pin="3Q" pad="17"/>
<connect gate="A" pin="4D" pad="5"/>
<connect gate="A" pin="4Q" pad="16"/>
<connect gate="A" pin="5D" pad="6"/>
<connect gate="A" pin="5Q" pad="15"/>
<connect gate="A" pin="6D" pad="7"/>
<connect gate="A" pin="6Q" pad="14"/>
<connect gate="A" pin="7D" pad="8"/>
<connect gate="A" pin="7Q" pad="13"/>
<connect gate="A" pin="8D" pad="9"/>
<connect gate="A" pin="8Q" pad="12"/>
<connect gate="A" pin="CLK" pad="11"/>
<connect gate="A" pin="OC" pad="1"/>
<connect gate="P" pin="GND" pad="10"/>
<connect gate="P" pin="VCC" pad="20"/>
</connects>
<technologies>
<technology name="AC"/>
<technology name="ACT"/>
<technology name="HC"/>
<technology name="HCT"/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="74ac-logic">
<description>&lt;b&gt;TTL Logic Devices, 74AC11xx and 74AC16xx Series&lt;/b&gt;&lt;p&gt;
Based on the following source:
&lt;ul&gt;
&lt;li&gt;www.ti.com
&lt;/ul&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="SSOP48DL">
<description>&lt;B&gt;Shrink Small Outline Package&lt;/b&gt;</description>
<wire x1="-7.747" y1="-3.81" x2="8.382" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="8.382" y1="-3.81" x2="8.382" y2="3.81" width="0.1524" layer="21"/>
<wire x1="8.382" y1="3.81" x2="-7.747" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-7.747" y1="-3.81" x2="-7.747" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-7.493" y1="-3.5306" x2="8.128" y2="-3.5306" width="0.0508" layer="21"/>
<wire x1="8.128" y1="3.5306" x2="8.128" y2="-3.5306" width="0.0508" layer="21"/>
<wire x1="8.128" y1="3.5306" x2="-7.493" y2="3.5306" width="0.0508" layer="21"/>
<wire x1="-7.493" y1="-3.5306" x2="-7.493" y2="3.5306" width="0.0508" layer="21"/>
<circle x="-6.35" y="-2.3622" radius="0.8128" width="0.1524" layer="21"/>
<smd name="1" x="-6.985" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="2" x="-6.35" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="3" x="-5.715" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="4" x="-5.08" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="5" x="-4.445" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="6" x="-3.81" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="7" x="-3.175" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="8" x="-2.54" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="9" x="-1.905" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="10" x="-1.27" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="11" x="-0.635" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="12" x="0" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="13" x="0.635" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="14" x="1.27" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="15" x="1.905" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="16" x="2.54" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="17" x="3.175" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="18" x="3.81" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="19" x="4.445" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="20" x="5.08" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="21" x="5.715" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="22" x="6.35" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="23" x="6.985" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="24" x="7.62" y="-4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="25" x="7.62" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="26" x="6.985" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="27" x="6.35" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="28" x="5.715" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="29" x="5.08" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="30" x="4.445" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="31" x="3.81" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="32" x="3.175" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="33" x="2.54" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="34" x="1.905" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="35" x="1.27" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="36" x="0.635" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="37" x="0" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="38" x="-0.635" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="39" x="-1.27" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="40" x="-1.905" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="41" x="-2.54" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="42" x="-3.175" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="43" x="-3.81" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="44" x="-4.445" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="45" x="-5.08" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="46" x="-5.715" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="47" x="-6.35" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<smd name="48" x="-6.985" y="4.8768" dx="0.3048" dy="1.4224" layer="1"/>
<text x="-8.001" y="-3.683" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="-6.223" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-0.127" y1="-5.334" x2="0.127" y2="-4.0894" layer="51"/>
<rectangle x1="-0.127" y1="-4.0894" x2="0.127" y2="-3.81" layer="21"/>
<rectangle x1="0.508" y1="-4.0894" x2="0.762" y2="-3.81" layer="21"/>
<rectangle x1="1.143" y1="-4.0894" x2="1.397" y2="-3.81" layer="21"/>
<rectangle x1="1.778" y1="-4.0894" x2="2.032" y2="-3.81" layer="21"/>
<rectangle x1="2.413" y1="-4.0894" x2="2.667" y2="-3.81" layer="21"/>
<rectangle x1="3.048" y1="-4.0894" x2="3.302" y2="-3.81" layer="21"/>
<rectangle x1="3.683" y1="-4.0894" x2="3.937" y2="-3.81" layer="21"/>
<rectangle x1="4.318" y1="-4.0894" x2="4.572" y2="-3.81" layer="21"/>
<rectangle x1="4.953" y1="-4.0894" x2="5.207" y2="-3.81" layer="21"/>
<rectangle x1="5.588" y1="-4.0894" x2="5.842" y2="-3.81" layer="21"/>
<rectangle x1="6.223" y1="-4.0894" x2="6.477" y2="-3.81" layer="21"/>
<rectangle x1="6.858" y1="-4.0894" x2="7.112" y2="-3.81" layer="21"/>
<rectangle x1="-0.762" y1="-4.0894" x2="-0.508" y2="-3.81" layer="21"/>
<rectangle x1="-1.397" y1="-4.0894" x2="-1.143" y2="-3.81" layer="21"/>
<rectangle x1="-2.032" y1="-4.0894" x2="-1.778" y2="-3.81" layer="21"/>
<rectangle x1="-2.667" y1="-4.0894" x2="-2.413" y2="-3.81" layer="21"/>
<rectangle x1="-3.302" y1="-4.0894" x2="-3.048" y2="-3.81" layer="21"/>
<rectangle x1="-3.937" y1="-4.0894" x2="-3.683" y2="-3.81" layer="21"/>
<rectangle x1="-4.572" y1="-4.0894" x2="-4.318" y2="-3.81" layer="21"/>
<rectangle x1="-5.207" y1="-4.0894" x2="-4.953" y2="-3.81" layer="21"/>
<rectangle x1="-5.842" y1="-4.0894" x2="-5.588" y2="-3.81" layer="21"/>
<rectangle x1="-6.477" y1="-4.0894" x2="-6.223" y2="-3.81" layer="21"/>
<rectangle x1="-6.477" y1="-5.334" x2="-6.223" y2="-4.0894" layer="51"/>
<rectangle x1="-5.842" y1="-5.334" x2="-5.588" y2="-4.0894" layer="51"/>
<rectangle x1="-5.207" y1="-5.334" x2="-4.953" y2="-4.0894" layer="51"/>
<rectangle x1="-4.572" y1="-5.334" x2="-4.318" y2="-4.0894" layer="51"/>
<rectangle x1="-3.937" y1="-5.334" x2="-3.683" y2="-4.0894" layer="51"/>
<rectangle x1="-3.302" y1="-5.334" x2="-3.048" y2="-4.0894" layer="51"/>
<rectangle x1="-2.667" y1="-5.334" x2="-2.413" y2="-4.0894" layer="51"/>
<rectangle x1="-2.032" y1="-5.334" x2="-1.778" y2="-4.0894" layer="51"/>
<rectangle x1="-1.397" y1="-5.334" x2="-1.143" y2="-4.0894" layer="51"/>
<rectangle x1="-0.762" y1="-5.334" x2="-0.508" y2="-4.0894" layer="51"/>
<rectangle x1="-7.112" y1="-4.0894" x2="-6.858" y2="-3.81" layer="21"/>
<rectangle x1="-7.112" y1="-5.334" x2="-6.858" y2="-4.0894" layer="51"/>
<rectangle x1="0.508" y1="-5.334" x2="0.762" y2="-4.0894" layer="51"/>
<rectangle x1="1.143" y1="-5.334" x2="1.397" y2="-4.0894" layer="51"/>
<rectangle x1="1.778" y1="-5.334" x2="2.032" y2="-4.0894" layer="51"/>
<rectangle x1="2.413" y1="-5.334" x2="2.667" y2="-4.0894" layer="51"/>
<rectangle x1="3.048" y1="-5.334" x2="3.302" y2="-4.0894" layer="51"/>
<rectangle x1="3.683" y1="-5.334" x2="3.937" y2="-4.0894" layer="51"/>
<rectangle x1="4.318" y1="-5.334" x2="4.572" y2="-4.0894" layer="51"/>
<rectangle x1="4.953" y1="-5.334" x2="5.207" y2="-4.0894" layer="51"/>
<rectangle x1="5.588" y1="-5.334" x2="5.842" y2="-4.0894" layer="51"/>
<rectangle x1="6.223" y1="-5.334" x2="6.477" y2="-4.0894" layer="51"/>
<rectangle x1="6.858" y1="-5.334" x2="7.112" y2="-4.0894" layer="51"/>
<rectangle x1="-0.127" y1="3.81" x2="0.127" y2="4.0894" layer="21"/>
<rectangle x1="-7.112" y1="3.81" x2="-6.858" y2="4.0894" layer="21"/>
<rectangle x1="-6.477" y1="3.81" x2="-6.223" y2="4.0894" layer="21"/>
<rectangle x1="-5.842" y1="3.81" x2="-5.588" y2="4.0894" layer="21"/>
<rectangle x1="-5.207" y1="3.81" x2="-4.953" y2="4.0894" layer="21"/>
<rectangle x1="-4.572" y1="3.81" x2="-4.318" y2="4.0894" layer="21"/>
<rectangle x1="-3.937" y1="3.81" x2="-3.683" y2="4.0894" layer="21"/>
<rectangle x1="-3.302" y1="3.81" x2="-3.048" y2="4.0894" layer="21"/>
<rectangle x1="-2.667" y1="3.81" x2="-2.413" y2="4.0894" layer="21"/>
<rectangle x1="-2.032" y1="3.81" x2="-1.778" y2="4.0894" layer="21"/>
<rectangle x1="-1.397" y1="3.81" x2="-1.143" y2="4.0894" layer="21"/>
<rectangle x1="-0.762" y1="3.81" x2="-0.508" y2="4.0894" layer="21"/>
<rectangle x1="0.508" y1="3.81" x2="0.762" y2="4.0894" layer="21"/>
<rectangle x1="1.143" y1="3.81" x2="1.397" y2="4.0894" layer="21"/>
<rectangle x1="1.778" y1="3.81" x2="2.032" y2="4.0894" layer="21"/>
<rectangle x1="2.413" y1="3.81" x2="2.667" y2="4.0894" layer="21"/>
<rectangle x1="3.048" y1="3.81" x2="3.302" y2="4.0894" layer="21"/>
<rectangle x1="3.683" y1="3.81" x2="3.937" y2="4.0894" layer="21"/>
<rectangle x1="4.318" y1="3.81" x2="4.572" y2="4.0894" layer="21"/>
<rectangle x1="4.953" y1="3.81" x2="5.207" y2="4.0894" layer="21"/>
<rectangle x1="5.588" y1="3.81" x2="5.842" y2="4.0894" layer="21"/>
<rectangle x1="6.223" y1="3.81" x2="6.477" y2="4.0894" layer="21"/>
<rectangle x1="6.858" y1="3.81" x2="7.112" y2="4.0894" layer="21"/>
<rectangle x1="7.493" y1="3.81" x2="7.747" y2="4.0894" layer="21"/>
<rectangle x1="7.493" y1="-4.0894" x2="7.747" y2="-3.81" layer="21"/>
<rectangle x1="7.493" y1="-5.334" x2="7.747" y2="-4.0894" layer="51"/>
<rectangle x1="-0.127" y1="4.0894" x2="0.127" y2="5.334" layer="51"/>
<rectangle x1="-7.112" y1="4.0894" x2="-6.858" y2="5.334" layer="51"/>
<rectangle x1="-6.477" y1="4.0894" x2="-6.223" y2="5.334" layer="51"/>
<rectangle x1="-5.842" y1="4.0894" x2="-5.588" y2="5.334" layer="51"/>
<rectangle x1="-5.207" y1="4.0894" x2="-4.953" y2="5.334" layer="51"/>
<rectangle x1="-4.572" y1="4.0894" x2="-4.318" y2="5.334" layer="51"/>
<rectangle x1="-3.937" y1="4.0894" x2="-3.683" y2="5.334" layer="51"/>
<rectangle x1="-3.302" y1="4.0894" x2="-3.048" y2="5.334" layer="51"/>
<rectangle x1="-2.667" y1="4.0894" x2="-2.413" y2="5.334" layer="51"/>
<rectangle x1="-2.032" y1="4.0894" x2="-1.778" y2="5.334" layer="51"/>
<rectangle x1="-1.397" y1="4.0894" x2="-1.143" y2="5.334" layer="51"/>
<rectangle x1="-0.762" y1="4.0894" x2="-0.508" y2="5.334" layer="51"/>
<rectangle x1="0.508" y1="4.0894" x2="0.762" y2="5.334" layer="51"/>
<rectangle x1="1.143" y1="4.0894" x2="1.397" y2="5.334" layer="51"/>
<rectangle x1="1.778" y1="4.0894" x2="2.032" y2="5.334" layer="51"/>
<rectangle x1="2.413" y1="4.0894" x2="2.667" y2="5.334" layer="51"/>
<rectangle x1="3.048" y1="4.0894" x2="3.302" y2="5.334" layer="51"/>
<rectangle x1="3.683" y1="4.0894" x2="3.937" y2="5.334" layer="51"/>
<rectangle x1="4.318" y1="4.0894" x2="4.572" y2="5.334" layer="51"/>
<rectangle x1="4.953" y1="4.0894" x2="5.207" y2="5.334" layer="51"/>
<rectangle x1="5.588" y1="4.0894" x2="5.842" y2="5.334" layer="51"/>
<rectangle x1="6.223" y1="4.0894" x2="6.477" y2="5.334" layer="51"/>
<rectangle x1="6.858" y1="4.0894" x2="7.112" y2="5.334" layer="51"/>
<rectangle x1="7.493" y1="4.0894" x2="7.747" y2="5.334" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="7416245">
<wire x1="-10.16" y1="27.94" x2="-10.16" y2="-27.94" width="0.4064" layer="94"/>
<wire x1="7.62" y1="-27.94" x2="-10.16" y2="-27.94" width="0.4064" layer="94"/>
<wire x1="7.62" y1="-27.94" x2="7.62" y2="27.94" width="0.4064" layer="94"/>
<wire x1="-10.16" y1="27.94" x2="7.62" y2="27.94" width="0.4064" layer="94"/>
<text x="-10.16" y="28.575" size="1.778" layer="95">&gt;NAME</text>
<text x="-10.16" y="-30.48" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1G" x="-15.24" y="-17.78" length="middle" direction="in" function="dot"/>
<pin name="1DIR" x="-15.24" y="-20.32" length="middle" direction="in" function="dot"/>
<pin name="2G" x="-15.24" y="-22.86" length="middle" direction="in" function="dot"/>
<pin name="2DIR" x="-15.24" y="-25.4" length="middle" direction="in" function="dot"/>
<pin name="1B1" x="12.7" y="25.4" length="middle" rot="R180"/>
<pin name="1B2" x="12.7" y="22.86" length="middle" rot="R180"/>
<pin name="1B3" x="12.7" y="20.32" length="middle" rot="R180"/>
<pin name="1B4" x="12.7" y="17.78" length="middle" rot="R180"/>
<pin name="1B5" x="12.7" y="15.24" length="middle" rot="R180"/>
<pin name="1B6" x="12.7" y="12.7" length="middle" rot="R180"/>
<pin name="1B7" x="12.7" y="10.16" length="middle" rot="R180"/>
<pin name="1B8" x="12.7" y="7.62" length="middle" rot="R180"/>
<pin name="2B1" x="12.7" y="5.08" length="middle" rot="R180"/>
<pin name="2B2" x="12.7" y="2.54" length="middle" rot="R180"/>
<pin name="2B3" x="12.7" y="0" length="middle" rot="R180"/>
<pin name="2B4" x="12.7" y="-2.54" length="middle" rot="R180"/>
<pin name="2B5" x="12.7" y="-5.08" length="middle" rot="R180"/>
<pin name="2B6" x="12.7" y="-7.62" length="middle" rot="R180"/>
<pin name="2B7" x="12.7" y="-10.16" length="middle" rot="R180"/>
<pin name="2B8" x="12.7" y="-12.7" length="middle" rot="R180"/>
<pin name="1A1" x="-15.24" y="25.4" length="middle"/>
<pin name="1A2" x="-15.24" y="22.86" length="middle"/>
<pin name="1A3" x="-15.24" y="20.32" length="middle"/>
<pin name="1A4" x="-15.24" y="17.78" length="middle"/>
<pin name="1A5" x="-15.24" y="15.24" length="middle"/>
<pin name="1A6" x="-15.24" y="12.7" length="middle"/>
<pin name="1A7" x="-15.24" y="10.16" length="middle"/>
<pin name="1A8" x="-15.24" y="7.62" length="middle"/>
<pin name="2A1" x="-15.24" y="5.08" length="middle"/>
<pin name="2A2" x="-15.24" y="2.54" length="middle"/>
<pin name="2A3" x="-15.24" y="0" length="middle"/>
<pin name="2A4" x="-15.24" y="-2.54" length="middle"/>
<pin name="2A5" x="-15.24" y="-5.08" length="middle"/>
<pin name="2A6" x="-15.24" y="-7.62" length="middle"/>
<pin name="2A7" x="-15.24" y="-10.16" length="middle"/>
<pin name="2A8" x="-15.24" y="-12.7" length="middle"/>
</symbol>
<symbol name="4PWR8GND">
<text x="-0.635" y="-0.635" size="1.778" layer="95">&gt;NAME</text>
<text x="6.985" y="2.54" size="1.27" layer="95" rot="R90">VCC</text>
<text x="14.605" y="-5.842" size="1.27" layer="95" rot="R90">GND</text>
<pin name="VCC@1" x="-2.54" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
<pin name="VCC@2" x="0" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
<pin name="GND@4" x="2.54" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="GND@3" x="0" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="GND@2" x="-2.54" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="GND@1" x="-5.08" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="VCC@3" x="2.54" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
<pin name="VCC@4" x="5.08" y="7.62" visible="pad" length="middle" direction="pwr" rot="R270"/>
<pin name="GND@5" x="5.08" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="GND@6" x="7.62" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="GND@7" x="10.16" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
<pin name="GND@8" x="12.7" y="-7.62" visible="pad" length="middle" direction="pwr" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="74AC16245" prefix="IC">
<description>16-bit &lt;B&gt;BUS TRANSCEIVER&lt;/B&gt;, 3-state</description>
<gates>
<gate name="G$1" symbol="7416245" x="0" y="-2.54"/>
<gate name="P" symbol="4PWR8GND" x="-35.56" y="0" addlevel="request"/>
</gates>
<devices>
<device name="" package="SSOP48DL">
<connects>
<connect gate="G$1" pin="1A1" pad="47"/>
<connect gate="G$1" pin="1A2" pad="46"/>
<connect gate="G$1" pin="1A3" pad="44"/>
<connect gate="G$1" pin="1A4" pad="43"/>
<connect gate="G$1" pin="1A5" pad="41"/>
<connect gate="G$1" pin="1A6" pad="40"/>
<connect gate="G$1" pin="1A7" pad="38"/>
<connect gate="G$1" pin="1A8" pad="37"/>
<connect gate="G$1" pin="1B1" pad="2"/>
<connect gate="G$1" pin="1B2" pad="3"/>
<connect gate="G$1" pin="1B3" pad="5"/>
<connect gate="G$1" pin="1B4" pad="6"/>
<connect gate="G$1" pin="1B5" pad="8"/>
<connect gate="G$1" pin="1B6" pad="9"/>
<connect gate="G$1" pin="1B7" pad="11"/>
<connect gate="G$1" pin="1B8" pad="12"/>
<connect gate="G$1" pin="1DIR" pad="1"/>
<connect gate="G$1" pin="1G" pad="48"/>
<connect gate="G$1" pin="2A1" pad="36"/>
<connect gate="G$1" pin="2A2" pad="35"/>
<connect gate="G$1" pin="2A3" pad="33"/>
<connect gate="G$1" pin="2A4" pad="32"/>
<connect gate="G$1" pin="2A5" pad="30"/>
<connect gate="G$1" pin="2A6" pad="29"/>
<connect gate="G$1" pin="2A7" pad="27"/>
<connect gate="G$1" pin="2A8" pad="26"/>
<connect gate="G$1" pin="2B1" pad="13"/>
<connect gate="G$1" pin="2B2" pad="14"/>
<connect gate="G$1" pin="2B3" pad="16"/>
<connect gate="G$1" pin="2B4" pad="17"/>
<connect gate="G$1" pin="2B5" pad="19"/>
<connect gate="G$1" pin="2B6" pad="20"/>
<connect gate="G$1" pin="2B7" pad="22"/>
<connect gate="G$1" pin="2B8" pad="23"/>
<connect gate="G$1" pin="2DIR" pad="24"/>
<connect gate="G$1" pin="2G" pad="25"/>
<connect gate="P" pin="GND@1" pad="4"/>
<connect gate="P" pin="GND@2" pad="10"/>
<connect gate="P" pin="GND@3" pad="15"/>
<connect gate="P" pin="GND@4" pad="21"/>
<connect gate="P" pin="GND@5" pad="28"/>
<connect gate="P" pin="GND@6" pad="34"/>
<connect gate="P" pin="GND@7" pad="39"/>
<connect gate="P" pin="GND@8" pad="45"/>
<connect gate="P" pin="VCC@1" pad="7"/>
<connect gate="P" pin="VCC@2" pad="18"/>
<connect gate="P" pin="VCC@3" pad="31"/>
<connect gate="P" pin="VCC@4" pad="42"/>
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
<part name="JP1" library="pinhead" deviceset="PINHD-1X14" device="" value="fila1"/>
<part name="JP2" library="pinhead" deviceset="PINHD-1X14" device="" value="fila2"/>
<part name="JP3" library="pinhead" deviceset="PINHD-1X14" device="" value="fila3"/>
<part name="GND3" library="supply1" deviceset="GND" device=""/>
<part name="U$2" library="zx_bus_connector_lado_spectrum" deviceset="CONECTOR_EDGE_LADO_SPECTRUM" device=""/>
<part name="IC1" library="74xx-eu" deviceset="74*574" device="D" technology="HC"/>
<part name="IC2" library="74xx-eu" deviceset="74*574" device="D" technology="HC"/>
<part name="IC3" library="74xx-eu" deviceset="74*574" device="D" technology="HC"/>
<part name="IC4" library="74xx-eu" deviceset="74*574" device="D" technology="HC"/>
<part name="GND1" library="supply1" deviceset="GND" device=""/>
<part name="P+2" library="supply1" deviceset="VCC" device=""/>
<part name="IC5" library="74ac-logic" deviceset="74AC16245" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="JP1" gate="A" x="-15.24" y="83.82" rot="MR0"/>
<instance part="JP2" gate="A" x="-15.24" y="38.1" rot="MR0"/>
<instance part="JP3" gate="A" x="-15.24" y="-15.24" rot="MR0"/>
<instance part="GND3" gate="1" x="40.64" y="71.12"/>
<instance part="U$2" gate="G$1" x="124.46" y="101.6"/>
<instance part="IC1" gate="A" x="55.88" y="121.92"/>
<instance part="IC2" gate="A" x="55.88" y="78.74"/>
<instance part="IC3" gate="A" x="55.88" y="33.02"/>
<instance part="IC4" gate="A" x="55.88" y="-10.16"/>
<instance part="GND1" gate="1" x="15.24" y="43.18"/>
<instance part="P+2" gate="VCC" x="15.24" y="58.42"/>
<instance part="IC5" gate="G$1" x="127" y="10.16"/>
</instances>
<busses>
</busses>
<nets>
<net name="VCC" class="0">
<segment>
<pinref part="JP1" gate="A" pin="1"/>
<wire x1="-12.7" y1="99.06" x2="-2.54" y2="99.06" width="0.1524" layer="91"/>
<label x="-7.62" y="99.06" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="P+2" gate="VCC" pin="VCC"/>
<wire x1="15.24" y1="55.88" x2="15.24" y2="53.34" width="0.1524" layer="91"/>
<wire x1="15.24" y1="53.34" x2="22.86" y2="53.34" width="0.1524" layer="91"/>
<label x="17.78" y="53.34" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="106.68" y1="129.54" x2="96.52" y2="129.54" width="0.1524" layer="91"/>
<label x="93.98" y="129.54" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="+5V"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<label x="-7.62" y="66.04" size="1.778" layer="95"/>
<wire x1="43.18" y1="109.22" x2="30.48" y2="109.22" width="0.1524" layer="91"/>
<wire x1="30.48" y1="109.22" x2="30.48" y2="66.04" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="14"/>
<wire x1="-12.7" y1="66.04" x2="30.48" y2="66.04" width="0.1524" layer="91"/>
<pinref part="IC1" gate="A" pin="OC"/>
<pinref part="IC2" gate="A" pin="OC"/>
<wire x1="43.18" y1="66.04" x2="30.48" y2="66.04" width="0.1524" layer="91"/>
<junction x="30.48" y="66.04"/>
</segment>
<segment>
<pinref part="IC4" gate="A" pin="OC"/>
<wire x1="27.94" y1="-22.86" x2="43.18" y2="-22.86" width="0.1524" layer="91"/>
<wire x1="27.94" y1="-22.86" x2="27.94" y2="-15.24" width="0.1524" layer="91"/>
<wire x1="27.94" y1="-15.24" x2="27.94" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="27.94" y1="-12.7" x2="27.94" y2="-10.16" width="0.1524" layer="91"/>
<wire x1="27.94" y1="-10.16" x2="27.94" y2="20.32" width="0.1524" layer="91"/>
<pinref part="IC3" gate="A" pin="OC"/>
<wire x1="43.18" y1="20.32" x2="27.94" y2="20.32" width="0.1524" layer="91"/>
<pinref part="IC4" gate="A" pin="6D"/>
<wire x1="43.18" y1="-10.16" x2="27.94" y2="-10.16" width="0.1524" layer="91"/>
<junction x="27.94" y="-10.16"/>
<pinref part="IC4" gate="A" pin="7D"/>
<wire x1="43.18" y1="-12.7" x2="27.94" y2="-12.7" width="0.1524" layer="91"/>
<junction x="27.94" y="-12.7"/>
<pinref part="IC4" gate="A" pin="8D"/>
<wire x1="43.18" y1="-15.24" x2="27.94" y2="-15.24" width="0.1524" layer="91"/>
<junction x="27.94" y="-15.24"/>
<pinref part="JP2" gate="A" pin="14"/>
<wire x1="-12.7" y1="20.32" x2="27.94" y2="20.32" width="0.1524" layer="91"/>
<junction x="27.94" y="20.32"/>
<label x="-7.62" y="20.32" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="106.68" y1="121.92" x2="96.52" y2="121.92" width="0.1524" layer="91"/>
<label x="93.98" y="121.92" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="GND1"/>
</segment>
<segment>
<wire x1="106.68" y1="119.38" x2="96.52" y2="119.38" width="0.1524" layer="91"/>
<label x="93.98" y="119.38" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="GND2"/>
</segment>
<segment>
<wire x1="106.68" y1="101.6" x2="96.52" y2="101.6" width="0.1524" layer="91"/>
<label x="93.98" y="101.6" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="GND3" gate="1" pin="GND"/>
<wire x1="40.64" y1="73.66" x2="43.18" y2="73.66" width="0.1524" layer="91"/>
<pinref part="IC2" gate="A" pin="6D"/>
<wire x1="43.18" y1="78.74" x2="40.64" y2="78.74" width="0.1524" layer="91"/>
<wire x1="40.64" y1="78.74" x2="40.64" y2="76.2" width="0.1524" layer="91"/>
<junction x="40.64" y="73.66"/>
<pinref part="IC2" gate="A" pin="7D"/>
<wire x1="40.64" y1="76.2" x2="40.64" y2="73.66" width="0.1524" layer="91"/>
<wire x1="43.18" y1="76.2" x2="40.64" y2="76.2" width="0.1524" layer="91"/>
<junction x="40.64" y="76.2"/>
<pinref part="IC2" gate="A" pin="8D"/>
</segment>
<segment>
<pinref part="JP3" gate="A" pin="14"/>
<wire x1="-12.7" y1="-33.02" x2="0" y2="-33.02" width="0.1524" layer="91"/>
<label x="-5.08" y="-33.02" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="GND1" gate="1" pin="GND"/>
<wire x1="15.24" y1="45.72" x2="15.24" y2="48.26" width="0.1524" layer="91"/>
<wire x1="15.24" y1="48.26" x2="22.86" y2="48.26" width="0.1524" layer="91"/>
<label x="17.78" y="48.26" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="IC5" gate="G$1" pin="1G"/>
<wire x1="111.76" y1="-7.62" x2="109.22" y2="-7.62" width="0.1524" layer="91"/>
<wire x1="109.22" y1="-7.62" x2="109.22" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="109.22" y1="-12.7" x2="109.22" y2="-15.24" width="0.1524" layer="91"/>
<wire x1="109.22" y1="-15.24" x2="99.06" y2="-15.24" width="0.1524" layer="91"/>
<label x="99.06" y="-15.24" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A8"/>
<wire x1="111.76" y1="-2.54" x2="109.22" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="109.22" y1="-2.54" x2="109.22" y2="-7.62" width="0.1524" layer="91"/>
<junction x="109.22" y="-7.62"/>
<pinref part="IC5" gate="G$1" pin="2G"/>
<wire x1="111.76" y1="-12.7" x2="109.22" y2="-12.7" width="0.1524" layer="91"/>
<junction x="109.22" y="-12.7"/>
<pinref part="IC5" gate="G$1" pin="2DIR"/>
<wire x1="111.76" y1="-15.24" x2="109.22" y2="-15.24" width="0.1524" layer="91"/>
<junction x="109.22" y="-15.24"/>
</segment>
</net>
<net name="EXT7" class="0">
<segment>
<pinref part="JP1" gate="A" pin="4"/>
<wire x1="-12.7" y1="91.44" x2="-2.54" y2="91.44" width="0.1524" layer="91"/>
<label x="-7.62" y="91.44" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="33.02" y1="127" x2="43.18" y2="127" width="0.1524" layer="91"/>
<label x="35.56" y="127" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="4D"/>
</segment>
<segment>
<wire x1="33.02" y1="38.1" x2="43.18" y2="38.1" width="0.1524" layer="91"/>
<label x="35.56" y="38.1" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="4D"/>
</segment>
</net>
<net name="EXT10" class="0">
<segment>
<wire x1="-12.7" y1="88.9" x2="-2.54" y2="88.9" width="0.1524" layer="91"/>
<label x="-7.62" y="88.9" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="5"/>
</segment>
<segment>
<wire x1="33.02" y1="121.92" x2="43.18" y2="121.92" width="0.1524" layer="91"/>
<label x="35.56" y="121.92" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="6D"/>
</segment>
<segment>
<wire x1="33.02" y1="33.02" x2="43.18" y2="33.02" width="0.1524" layer="91"/>
<label x="35.56" y="33.02" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="6D"/>
</segment>
</net>
<net name="EXT13" class="0">
<segment>
<wire x1="-12.7" y1="86.36" x2="-2.54" y2="86.36" width="0.1524" layer="91"/>
<label x="-7.62" y="86.36" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="6"/>
</segment>
<segment>
<wire x1="33.02" y1="27.94" x2="43.18" y2="27.94" width="0.1524" layer="91"/>
<label x="35.56" y="27.94" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="8D"/>
</segment>
<segment>
<wire x1="33.02" y1="116.84" x2="43.18" y2="116.84" width="0.1524" layer="91"/>
<label x="35.56" y="116.84" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="8D"/>
</segment>
</net>
<net name="EXT16" class="0">
<segment>
<wire x1="-12.7" y1="83.82" x2="-2.54" y2="83.82" width="0.1524" layer="91"/>
<label x="-7.62" y="83.82" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="7"/>
</segment>
<segment>
<wire x1="139.7" y1="2.54" x2="152.4" y2="2.54" width="0.1524" layer="91"/>
<label x="149.86" y="2.54" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B6"/>
</segment>
</net>
<net name="EXT19" class="0">
<segment>
<wire x1="-12.7" y1="81.28" x2="-2.54" y2="81.28" width="0.1524" layer="91"/>
<label x="-7.62" y="81.28" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="8"/>
</segment>
<segment>
<wire x1="139.7" y1="10.16" x2="152.4" y2="10.16" width="0.1524" layer="91"/>
<label x="149.86" y="10.16" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B3"/>
</segment>
</net>
<net name="EXT22" class="0">
<segment>
<wire x1="-12.7" y1="78.74" x2="-2.54" y2="78.74" width="0.1524" layer="91"/>
<label x="-7.62" y="78.74" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="9"/>
</segment>
<segment>
<wire x1="152.4" y1="17.78" x2="139.7" y2="17.78" width="0.1524" layer="91"/>
<label x="149.86" y="17.78" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B8"/>
</segment>
</net>
<net name="EXT25" class="0">
<segment>
<wire x1="-12.7" y1="76.2" x2="-2.54" y2="76.2" width="0.1524" layer="91"/>
<label x="-7.62" y="76.2" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="10"/>
</segment>
<segment>
<wire x1="152.4" y1="25.4" x2="139.7" y2="25.4" width="0.1524" layer="91"/>
<label x="149.86" y="25.4" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B5"/>
</segment>
</net>
<net name="EXT28" class="0">
<segment>
<wire x1="-12.7" y1="73.66" x2="-2.54" y2="73.66" width="0.1524" layer="91"/>
<label x="-7.62" y="73.66" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="11"/>
</segment>
<segment>
<wire x1="152.4" y1="27.94" x2="139.7" y2="27.94" width="0.1524" layer="91"/>
<label x="149.86" y="27.94" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B4"/>
</segment>
</net>
<net name="EXT31" class="0">
<segment>
<pinref part="JP1" gate="A" pin="12"/>
<wire x1="-12.7" y1="71.12" x2="-2.54" y2="71.12" width="0.1524" layer="91"/>
<label x="-7.62" y="71.12" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="152.4" y1="33.02" x2="139.7" y2="33.02" width="0.1524" layer="91"/>
<label x="149.86" y="33.02" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B2"/>
</segment>
</net>
<net name="EXT34" class="0">
<segment>
<wire x1="-12.7" y1="68.58" x2="-2.54" y2="68.58" width="0.1524" layer="91"/>
<label x="-7.62" y="68.58" size="1.778" layer="95"/>
<pinref part="JP1" gate="A" pin="13"/>
</segment>
<segment>
<wire x1="43.18" y1="88.9" x2="33.02" y2="88.9" width="0.1524" layer="91"/>
<label x="35.56" y="88.9" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="2D"/>
</segment>
<segment>
<wire x1="43.18" y1="0" x2="33.02" y2="0" width="0.1524" layer="91"/>
<label x="35.56" y="0" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="2D"/>
</segment>
</net>
<net name="EXT8" class="0">
<segment>
<wire x1="-12.7" y1="45.72" x2="0" y2="45.72" width="0.1524" layer="91"/>
<label x="-7.62" y="45.72" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="4"/>
</segment>
<segment>
<wire x1="33.02" y1="129.54" x2="43.18" y2="129.54" width="0.1524" layer="91"/>
<label x="35.56" y="129.54" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="3D"/>
</segment>
<segment>
<wire x1="33.02" y1="40.64" x2="43.18" y2="40.64" width="0.1524" layer="91"/>
<label x="35.56" y="40.64" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="3D"/>
</segment>
</net>
<net name="A0" class="0">
<segment>
<wire x1="106.68" y1="114.3" x2="96.52" y2="114.3" width="0.1524" layer="91"/>
<label x="93.98" y="114.3" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A0"/>
</segment>
<segment>
<wire x1="78.74" y1="121.92" x2="68.58" y2="121.92" width="0.1524" layer="91"/>
<label x="73.66" y="121.92" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="6Q"/>
</segment>
</net>
<net name="A1" class="0">
<segment>
<wire x1="106.68" y1="111.76" x2="96.52" y2="111.76" width="0.1524" layer="91"/>
<label x="93.98" y="111.76" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A1"/>
</segment>
<segment>
<wire x1="78.74" y1="119.38" x2="68.58" y2="119.38" width="0.1524" layer="91"/>
<label x="73.66" y="119.38" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="7Q"/>
</segment>
</net>
<net name="A2" class="0">
<segment>
<wire x1="106.68" y1="109.22" x2="96.52" y2="109.22" width="0.1524" layer="91"/>
<label x="93.98" y="109.22" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A2"/>
</segment>
<segment>
<wire x1="78.74" y1="116.84" x2="68.58" y2="116.84" width="0.1524" layer="91"/>
<label x="73.66" y="116.84" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="8Q"/>
</segment>
</net>
<net name="A3" class="0">
<segment>
<wire x1="106.68" y1="106.68" x2="96.52" y2="106.68" width="0.1524" layer="91"/>
<label x="93.98" y="106.68" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A3"/>
</segment>
<segment>
<wire x1="78.74" y1="27.94" x2="68.58" y2="27.94" width="0.1524" layer="91"/>
<label x="73.66" y="27.94" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="8Q"/>
</segment>
</net>
<net name="A4" class="0">
<segment>
<wire x1="106.68" y1="76.2" x2="96.52" y2="76.2" width="0.1524" layer="91"/>
<label x="93.98" y="76.2" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A4"/>
</segment>
<segment>
<wire x1="78.74" y1="-2.54" x2="68.58" y2="-2.54" width="0.1524" layer="91"/>
<label x="73.66" y="-2.54" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="3Q"/>
</segment>
</net>
<net name="A5" class="0">
<segment>
<wire x1="106.68" y1="78.74" x2="96.52" y2="78.74" width="0.1524" layer="91"/>
<label x="93.98" y="78.74" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A5"/>
</segment>
<segment>
<wire x1="78.74" y1="0" x2="68.58" y2="0" width="0.1524" layer="91"/>
<label x="73.66" y="0" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="2Q"/>
</segment>
</net>
<net name="A6" class="0">
<segment>
<wire x1="106.68" y1="81.28" x2="96.52" y2="81.28" width="0.1524" layer="91"/>
<label x="93.98" y="81.28" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A6"/>
</segment>
<segment>
<wire x1="78.74" y1="2.54" x2="68.58" y2="2.54" width="0.1524" layer="91"/>
<label x="73.66" y="2.54" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="1Q"/>
</segment>
</net>
<net name="A7" class="0">
<segment>
<wire x1="106.68" y1="83.82" x2="96.52" y2="83.82" width="0.1524" layer="91"/>
<label x="93.98" y="83.82" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A7"/>
</segment>
<segment>
<wire x1="78.74" y1="45.72" x2="68.58" y2="45.72" width="0.1524" layer="91"/>
<label x="73.66" y="45.72" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="1Q"/>
</segment>
</net>
<net name="A8" class="0">
<segment>
<wire x1="154.94" y1="71.12" x2="144.78" y2="71.12" width="0.1524" layer="91"/>
<label x="147.32" y="71.12" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A8"/>
</segment>
<segment>
<wire x1="78.74" y1="88.9" x2="68.58" y2="88.9" width="0.1524" layer="91"/>
<label x="73.66" y="88.9" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="2Q"/>
</segment>
</net>
<net name="A9" class="0">
<segment>
<wire x1="106.68" y1="68.58" x2="96.52" y2="68.58" width="0.1524" layer="91"/>
<label x="93.98" y="68.58" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A9"/>
</segment>
<segment>
<wire x1="78.74" y1="86.36" x2="68.58" y2="86.36" width="0.1524" layer="91"/>
<label x="73.66" y="86.36" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="3Q"/>
</segment>
</net>
<net name="A10" class="0">
<segment>
<wire x1="154.94" y1="68.58" x2="144.78" y2="68.58" width="0.1524" layer="91"/>
<label x="147.32" y="68.58" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A10"/>
</segment>
<segment>
<wire x1="78.74" y1="83.82" x2="68.58" y2="83.82" width="0.1524" layer="91"/>
<label x="73.66" y="83.82" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="4Q"/>
</segment>
</net>
<net name="A11" class="0">
<segment>
<wire x1="106.68" y1="66.04" x2="96.52" y2="66.04" width="0.1524" layer="91"/>
<label x="93.98" y="66.04" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A11"/>
</segment>
<segment>
<wire x1="78.74" y1="81.28" x2="68.58" y2="81.28" width="0.1524" layer="91"/>
<label x="73.66" y="81.28" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="5Q"/>
</segment>
</net>
<net name="A12" class="0">
<segment>
<wire x1="106.68" y1="132.08" x2="96.52" y2="132.08" width="0.1524" layer="91"/>
<label x="93.98" y="132.08" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A12"/>
</segment>
<segment>
<wire x1="78.74" y1="127" x2="68.58" y2="127" width="0.1524" layer="91"/>
<label x="73.66" y="127" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="4Q"/>
</segment>
</net>
<net name="A13" class="0">
<segment>
<wire x1="154.94" y1="132.08" x2="144.78" y2="132.08" width="0.1524" layer="91"/>
<label x="147.32" y="132.08" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A13"/>
</segment>
<segment>
<wire x1="78.74" y1="129.54" x2="68.58" y2="129.54" width="0.1524" layer="91"/>
<label x="73.66" y="129.54" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="3Q"/>
</segment>
</net>
<net name="A14" class="0">
<segment>
<wire x1="106.68" y1="134.62" x2="96.52" y2="134.62" width="0.1524" layer="91"/>
<label x="93.98" y="134.62" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A14"/>
</segment>
<segment>
<wire x1="78.74" y1="132.08" x2="68.58" y2="132.08" width="0.1524" layer="91"/>
<label x="73.66" y="132.08" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="2Q"/>
</segment>
</net>
<net name="A15" class="0">
<segment>
<wire x1="154.94" y1="134.62" x2="144.78" y2="134.62" width="0.1524" layer="91"/>
<label x="147.32" y="134.62" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="A15"/>
</segment>
<segment>
<wire x1="78.74" y1="134.62" x2="68.58" y2="134.62" width="0.1524" layer="91"/>
<label x="73.66" y="134.62" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="1Q"/>
</segment>
</net>
<net name="/RFSH" class="0">
<segment>
<wire x1="154.94" y1="73.66" x2="144.78" y2="73.66" width="0.1524" layer="91"/>
<label x="147.32" y="73.66" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="RFSH"/>
</segment>
<segment>
<wire x1="78.74" y1="-7.62" x2="68.58" y2="-7.62" width="0.1524" layer="91"/>
<label x="73.66" y="-7.62" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="5Q"/>
</segment>
</net>
<net name="/M1" class="0">
<segment>
<wire x1="154.94" y1="76.2" x2="144.78" y2="76.2" width="0.1524" layer="91"/>
<label x="147.32" y="76.2" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="M1"/>
</segment>
<segment>
<wire x1="78.74" y1="-5.08" x2="68.58" y2="-5.08" width="0.1524" layer="91"/>
<label x="73.66" y="-5.08" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="4Q"/>
</segment>
</net>
<net name="/HALT" class="0">
<segment>
<wire x1="154.94" y1="99.06" x2="144.78" y2="99.06" width="0.1524" layer="91"/>
<label x="147.32" y="99.06" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="HALT"/>
</segment>
<segment>
<wire x1="78.74" y1="33.02" x2="68.58" y2="33.02" width="0.1524" layer="91"/>
<label x="73.66" y="33.02" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="6Q"/>
</segment>
</net>
<net name="/BUSAK" class="0">
<segment>
<wire x1="106.68" y1="71.12" x2="96.52" y2="71.12" width="0.1524" layer="91"/>
<label x="93.98" y="71.12" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="BUSACK"/>
</segment>
<segment>
<wire x1="78.74" y1="91.44" x2="68.58" y2="91.44" width="0.1524" layer="91"/>
<label x="73.66" y="91.44" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="1Q"/>
</segment>
</net>
<net name="/MREQ" class="0">
<segment>
<wire x1="154.94" y1="96.52" x2="144.78" y2="96.52" width="0.1524" layer="91"/>
<label x="147.32" y="96.52" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="MREQ"/>
</segment>
<segment>
<wire x1="78.74" y1="35.56" x2="68.58" y2="35.56" width="0.1524" layer="91"/>
<label x="73.66" y="35.56" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="5Q"/>
</segment>
</net>
<net name="/IORQ" class="0">
<segment>
<wire x1="154.94" y1="93.98" x2="144.78" y2="93.98" width="0.1524" layer="91"/>
<label x="147.32" y="93.98" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="IORQ"/>
</segment>
<segment>
<wire x1="78.74" y1="38.1" x2="68.58" y2="38.1" width="0.1524" layer="91"/>
<label x="73.66" y="38.1" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="4Q"/>
</segment>
</net>
<net name="/WR" class="0">
<segment>
<wire x1="154.94" y1="88.9" x2="144.78" y2="88.9" width="0.1524" layer="91"/>
<label x="147.32" y="88.9" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="WR"/>
</segment>
<segment>
<wire x1="78.74" y1="43.18" x2="68.58" y2="43.18" width="0.1524" layer="91"/>
<label x="73.66" y="43.18" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="2Q"/>
</segment>
</net>
<net name="/RD" class="0">
<segment>
<wire x1="154.94" y1="91.44" x2="144.78" y2="91.44" width="0.1524" layer="91"/>
<label x="147.32" y="91.44" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="RD"/>
</segment>
<segment>
<label x="99.06" y="-10.16" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1DIR"/>
<wire x1="99.06" y1="-10.16" x2="111.76" y2="-10.16" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="78.74" y1="40.64" x2="68.58" y2="40.64" width="0.1524" layer="91"/>
<label x="73.66" y="40.64" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="3Q"/>
</segment>
</net>
<net name="EXT11" class="0">
<segment>
<wire x1="-12.7" y1="43.18" x2="0" y2="43.18" width="0.1524" layer="91"/>
<label x="-7.62" y="43.18" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="5"/>
</segment>
<segment>
<wire x1="33.02" y1="119.38" x2="43.18" y2="119.38" width="0.1524" layer="91"/>
<label x="35.56" y="119.38" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="7D"/>
</segment>
<segment>
<wire x1="33.02" y1="30.48" x2="43.18" y2="30.48" width="0.1524" layer="91"/>
<label x="35.56" y="30.48" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="7D"/>
</segment>
</net>
<net name="EXT14" class="0">
<segment>
<wire x1="-12.7" y1="40.64" x2="0" y2="40.64" width="0.1524" layer="91"/>
<label x="-7.62" y="40.64" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="6"/>
</segment>
<segment>
<wire x1="139.7" y1="0" x2="152.4" y2="0" width="0.1524" layer="91"/>
<label x="149.86" y="0" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B7"/>
</segment>
</net>
<net name="CKEXT" class="0">
<segment>
<wire x1="106.68" y1="116.84" x2="96.52" y2="116.84" width="0.1524" layer="91"/>
<label x="93.98" y="116.84" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="CLK"/>
</segment>
<segment>
<wire x1="78.74" y1="124.46" x2="68.58" y2="124.46" width="0.1524" layer="91"/>
<label x="73.66" y="124.46" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="5Q"/>
</segment>
</net>
<net name="/IORQULA" class="0">
<segment>
<wire x1="106.68" y1="104.14" x2="96.52" y2="104.14" width="0.1524" layer="91"/>
<label x="93.98" y="104.14" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="IORQGE"/>
</segment>
<segment>
<wire x1="78.74" y1="30.48" x2="68.58" y2="30.48" width="0.1524" layer="91"/>
<label x="73.66" y="30.48" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="7Q"/>
</segment>
</net>
<net name="D7" class="0">
<segment>
<wire x1="154.94" y1="129.54" x2="144.78" y2="129.54" width="0.1524" layer="91"/>
<label x="147.32" y="129.54" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D7"/>
</segment>
<segment>
<wire x1="111.76" y1="17.78" x2="101.6" y2="17.78" width="0.1524" layer="91"/>
<label x="104.14" y="17.78" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A8"/>
</segment>
</net>
<net name="D6" class="0">
<segment>
<wire x1="154.94" y1="114.3" x2="144.78" y2="114.3" width="0.1524" layer="91"/>
<label x="147.32" y="114.3" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D6"/>
</segment>
<segment>
<wire x1="111.76" y1="27.94" x2="101.6" y2="27.94" width="0.1524" layer="91"/>
<label x="104.14" y="27.94" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A4"/>
</segment>
</net>
<net name="/INT" class="0">
<segment>
<wire x1="154.94" y1="104.14" x2="144.78" y2="104.14" width="0.1524" layer="91"/>
<label x="147.32" y="104.14" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="INT"/>
</segment>
<segment>
<wire x1="101.6" y1="2.54" x2="111.76" y2="2.54" width="0.1524" layer="91"/>
<label x="104.14" y="2.54" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A6"/>
</segment>
</net>
<net name="/WAIT" class="0">
<segment>
<wire x1="154.94" y1="83.82" x2="144.78" y2="83.82" width="0.1524" layer="91"/>
<label x="147.32" y="83.82" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="WAIT"/>
</segment>
<segment>
<wire x1="101.6" y1="15.24" x2="111.76" y2="15.24" width="0.1524" layer="91"/>
<label x="104.14" y="15.24" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A1"/>
</segment>
</net>
<net name="ROM2" class="0">
<segment>
<wire x1="106.68" y1="99.06" x2="96.52" y2="99.06" width="0.1524" layer="91"/>
<label x="93.98" y="99.06" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="VIDEO/ROM2OE"/>
</segment>
<segment>
<wire x1="101.6" y1="7.62" x2="111.76" y2="7.62" width="0.1524" layer="91"/>
<label x="104.14" y="7.62" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A4"/>
</segment>
</net>
<net name="ROM1" class="0">
<segment>
<wire x1="154.94" y1="127" x2="144.78" y2="127" width="0.1524" layer="91"/>
<label x="147.32" y="127" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="ROM1OE"/>
</segment>
<segment>
<wire x1="106.68" y1="73.66" x2="96.52" y2="73.66" width="0.1524" layer="91"/>
<label x="93.98" y="73.66" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="ROMCS"/>
</segment>
<segment>
<wire x1="101.6" y1="0" x2="111.76" y2="0" width="0.1524" layer="91"/>
<label x="104.14" y="0" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A7"/>
</segment>
</net>
<net name="D0" class="0">
<segment>
<wire x1="154.94" y1="121.92" x2="144.78" y2="121.92" width="0.1524" layer="91"/>
<label x="147.32" y="121.92" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D0"/>
</segment>
<segment>
<wire x1="111.76" y1="20.32" x2="101.6" y2="20.32" width="0.1524" layer="91"/>
<label x="104.14" y="20.32" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A7"/>
</segment>
</net>
<net name="D1" class="0">
<segment>
<wire x1="154.94" y1="119.38" x2="144.78" y2="119.38" width="0.1524" layer="91"/>
<label x="147.32" y="119.38" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D1"/>
</segment>
<segment>
<wire x1="111.76" y1="22.86" x2="101.6" y2="22.86" width="0.1524" layer="91"/>
<label x="104.14" y="22.86" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A6"/>
</segment>
</net>
<net name="D2" class="0">
<segment>
<wire x1="154.94" y1="116.84" x2="144.78" y2="116.84" width="0.1524" layer="91"/>
<label x="147.32" y="116.84" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D2"/>
</segment>
<segment>
<wire x1="111.76" y1="25.4" x2="101.6" y2="25.4" width="0.1524" layer="91"/>
<label x="104.14" y="25.4" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A5"/>
</segment>
</net>
<net name="D5" class="0">
<segment>
<wire x1="154.94" y1="111.76" x2="144.78" y2="111.76" width="0.1524" layer="91"/>
<label x="147.32" y="111.76" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D5"/>
</segment>
<segment>
<wire x1="111.76" y1="30.48" x2="101.6" y2="30.48" width="0.1524" layer="91"/>
<label x="104.14" y="30.48" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A3"/>
</segment>
</net>
<net name="D3" class="0">
<segment>
<wire x1="154.94" y1="109.22" x2="144.78" y2="109.22" width="0.1524" layer="91"/>
<label x="147.32" y="109.22" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D3"/>
</segment>
<segment>
<wire x1="111.76" y1="33.02" x2="101.6" y2="33.02" width="0.1524" layer="91"/>
<label x="104.14" y="33.02" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A2"/>
</segment>
</net>
<net name="D4" class="0">
<segment>
<wire x1="154.94" y1="106.68" x2="144.78" y2="106.68" width="0.1524" layer="91"/>
<label x="147.32" y="106.68" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="D4"/>
</segment>
<segment>
<wire x1="111.76" y1="35.56" x2="101.6" y2="35.56" width="0.1524" layer="91"/>
<label x="104.14" y="35.56" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="1A1"/>
</segment>
</net>
<net name="/NMI" class="0">
<segment>
<wire x1="154.94" y1="101.6" x2="144.78" y2="101.6" width="0.1524" layer="91"/>
<label x="147.32" y="101.6" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="NMI"/>
</segment>
<segment>
<wire x1="101.6" y1="5.08" x2="111.76" y2="5.08" width="0.1524" layer="91"/>
<label x="104.14" y="5.08" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A5"/>
</segment>
</net>
<net name="/RESET" class="0">
<segment>
<wire x1="106.68" y1="86.36" x2="96.52" y2="86.36" width="0.1524" layer="91"/>
<label x="93.98" y="86.36" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="RESET"/>
</segment>
<segment>
<wire x1="101.6" y1="12.7" x2="111.76" y2="12.7" width="0.1524" layer="91"/>
<label x="104.14" y="12.7" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A2"/>
</segment>
</net>
<net name="EXT17" class="0">
<segment>
<wire x1="-12.7" y1="38.1" x2="0" y2="38.1" width="0.1524" layer="91"/>
<label x="-7.62" y="38.1" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="7"/>
</segment>
<segment>
<wire x1="139.7" y1="5.08" x2="152.4" y2="5.08" width="0.1524" layer="91"/>
<label x="149.86" y="5.08" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B5"/>
</segment>
</net>
<net name="EXT20" class="0">
<segment>
<wire x1="-12.7" y1="35.56" x2="0" y2="35.56" width="0.1524" layer="91"/>
<label x="-7.62" y="35.56" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="8"/>
</segment>
<segment>
<wire x1="139.7" y1="12.7" x2="152.4" y2="12.7" width="0.1524" layer="91"/>
<label x="149.86" y="12.7" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B2"/>
</segment>
</net>
<net name="EXT23" class="0">
<segment>
<wire x1="-12.7" y1="33.02" x2="0" y2="33.02" width="0.1524" layer="91"/>
<label x="-7.62" y="33.02" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="9"/>
</segment>
<segment>
<wire x1="152.4" y1="20.32" x2="139.7" y2="20.32" width="0.1524" layer="91"/>
<label x="149.86" y="20.32" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B7"/>
</segment>
</net>
<net name="EXT26" class="0">
<segment>
<wire x1="-12.7" y1="30.48" x2="0" y2="30.48" width="0.1524" layer="91"/>
<label x="-7.62" y="30.48" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="10"/>
</segment>
<segment>
<wire x1="43.18" y1="22.86" x2="30.48" y2="22.86" width="0.1524" layer="91"/>
<pinref part="IC3" gate="A" pin="CLK"/>
<wire x1="30.48" y1="22.86" x2="30.48" y2="-20.32" width="0.1524" layer="91"/>
<wire x1="43.18" y1="-20.32" x2="30.48" y2="-20.32" width="0.1524" layer="91"/>
<pinref part="IC4" gate="A" pin="CLK"/>
<label x="30.48" y="22.86" size="1.778" layer="95"/>
</segment>
</net>
<net name="EXT29" class="0">
<segment>
<wire x1="-12.7" y1="27.94" x2="0" y2="27.94" width="0.1524" layer="91"/>
<label x="-7.62" y="27.94" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="11"/>
</segment>
<segment>
<wire x1="152.4" y1="30.48" x2="139.7" y2="30.48" width="0.1524" layer="91"/>
<label x="149.86" y="30.48" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B3"/>
</segment>
</net>
<net name="EXT32" class="0">
<segment>
<wire x1="-12.7" y1="25.4" x2="0" y2="25.4" width="0.1524" layer="91"/>
<label x="-7.62" y="25.4" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="12"/>
</segment>
<segment>
<wire x1="152.4" y1="35.56" x2="139.7" y2="35.56" width="0.1524" layer="91"/>
<label x="149.86" y="35.56" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B1"/>
</segment>
</net>
<net name="EXT35" class="0">
<segment>
<wire x1="-12.7" y1="22.86" x2="0" y2="22.86" width="0.1524" layer="91"/>
<label x="-7.62" y="22.86" size="1.778" layer="95"/>
<pinref part="JP2" gate="A" pin="13"/>
</segment>
<segment>
<wire x1="43.18" y1="-5.08" x2="33.02" y2="-5.08" width="0.1524" layer="91"/>
<label x="35.56" y="-5.08" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="4D"/>
</segment>
<segment>
<wire x1="43.18" y1="83.82" x2="33.02" y2="83.82" width="0.1524" layer="91"/>
<label x="35.56" y="83.82" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="4D"/>
</segment>
</net>
<net name="/BUSRQ" class="0">
<segment>
<wire x1="106.68" y1="88.9" x2="96.52" y2="88.9" width="0.1524" layer="91"/>
<label x="93.98" y="88.9" size="1.778" layer="95"/>
<pinref part="U$2" gate="G$1" pin="BUSRQ"/>
</segment>
<segment>
<wire x1="101.6" y1="10.16" x2="111.76" y2="10.16" width="0.1524" layer="91"/>
<label x="104.14" y="10.16" size="1.778" layer="95"/>
<pinref part="IC5" gate="G$1" pin="2A3"/>
</segment>
</net>
<net name="EXT27" class="0">
<segment>
<wire x1="-12.7" y1="-22.86" x2="0" y2="-22.86" width="0.1524" layer="91"/>
<label x="-5.08" y="-22.86" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="10"/>
</segment>
<segment>
<wire x1="43.18" y1="91.44" x2="33.02" y2="91.44" width="0.1524" layer="91"/>
<label x="35.56" y="91.44" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="1D"/>
</segment>
<segment>
<wire x1="43.18" y1="2.54" x2="33.02" y2="2.54" width="0.1524" layer="91"/>
<label x="35.56" y="2.54" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="1D"/>
</segment>
</net>
<net name="EXT3" class="0">
<segment>
<pinref part="JP3" gate="A" pin="2"/>
<wire x1="-12.7" y1="-2.54" x2="0" y2="-2.54" width="0.1524" layer="91"/>
<label x="-5.08" y="-2.54" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="33.02" y1="134.62" x2="43.18" y2="134.62" width="0.1524" layer="91"/>
<label x="35.56" y="134.62" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="1D"/>
</segment>
<segment>
<wire x1="33.02" y1="45.72" x2="43.18" y2="45.72" width="0.1524" layer="91"/>
<label x="35.56" y="45.72" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="1D"/>
</segment>
</net>
<net name="EXT9" class="0">
<segment>
<wire x1="-12.7" y1="-7.62" x2="0" y2="-7.62" width="0.1524" layer="91"/>
<label x="-5.08" y="-7.62" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="4"/>
</segment>
<segment>
<wire x1="33.02" y1="132.08" x2="43.18" y2="132.08" width="0.1524" layer="91"/>
<label x="35.56" y="132.08" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="2D"/>
</segment>
<segment>
<wire x1="33.02" y1="43.18" x2="43.18" y2="43.18" width="0.1524" layer="91"/>
<label x="35.56" y="43.18" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="2D"/>
</segment>
</net>
<net name="EXT12" class="0">
<segment>
<wire x1="-12.7" y1="-10.16" x2="0" y2="-10.16" width="0.1524" layer="91"/>
<label x="-5.08" y="-10.16" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="5"/>
</segment>
<segment>
<wire x1="33.02" y1="124.46" x2="43.18" y2="124.46" width="0.1524" layer="91"/>
<label x="35.56" y="124.46" size="1.778" layer="95"/>
<pinref part="IC1" gate="A" pin="5D"/>
</segment>
<segment>
<wire x1="33.02" y1="35.56" x2="43.18" y2="35.56" width="0.1524" layer="91"/>
<label x="35.56" y="35.56" size="1.778" layer="95"/>
<pinref part="IC3" gate="A" pin="5D"/>
</segment>
</net>
<net name="EXT15" class="0">
<segment>
<wire x1="-12.7" y1="-12.7" x2="0" y2="-12.7" width="0.1524" layer="91"/>
<label x="-5.08" y="-12.7" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="6"/>
</segment>
</net>
<net name="EXT18" class="0">
<segment>
<wire x1="-12.7" y1="-15.24" x2="0" y2="-15.24" width="0.1524" layer="91"/>
<label x="-5.08" y="-15.24" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="7"/>
</segment>
<segment>
<wire x1="139.7" y1="7.62" x2="152.4" y2="7.62" width="0.1524" layer="91"/>
<label x="149.86" y="7.62" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B4"/>
</segment>
</net>
<net name="EXT21" class="0">
<segment>
<wire x1="-12.7" y1="-17.78" x2="0" y2="-17.78" width="0.1524" layer="91"/>
<label x="-5.08" y="-17.78" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="8"/>
</segment>
<segment>
<wire x1="139.7" y1="15.24" x2="152.4" y2="15.24" width="0.1524" layer="91"/>
<label x="149.86" y="15.24" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="2B1"/>
</segment>
</net>
<net name="EXT24" class="0">
<segment>
<wire x1="-12.7" y1="-20.32" x2="0" y2="-20.32" width="0.1524" layer="91"/>
<label x="-5.08" y="-20.32" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="9"/>
</segment>
<segment>
<wire x1="152.4" y1="22.86" x2="139.7" y2="22.86" width="0.1524" layer="91"/>
<label x="149.86" y="22.86" size="1.778" layer="95" rot="R180"/>
<pinref part="IC5" gate="G$1" pin="1B6"/>
</segment>
</net>
<net name="+3.3V" class="0">
<segment>
<pinref part="JP3" gate="A" pin="1"/>
<wire x1="-12.7" y1="0" x2="0" y2="0" width="0.1524" layer="91"/>
<label x="-5.08" y="0" size="1.778" layer="95"/>
</segment>
</net>
<net name="EXT36" class="0">
<segment>
<pinref part="JP3" gate="A" pin="13"/>
<wire x1="-12.7" y1="-30.48" x2="0" y2="-30.48" width="0.1524" layer="91"/>
<label x="-5.08" y="-30.48" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="27.94" y1="111.76" x2="43.18" y2="111.76" width="0.1524" layer="91"/>
<wire x1="43.18" y1="68.58" x2="27.94" y2="68.58" width="0.1524" layer="91"/>
<wire x1="27.94" y1="68.58" x2="27.94" y2="111.76" width="0.1524" layer="91"/>
<pinref part="IC1" gate="A" pin="CLK"/>
<pinref part="IC2" gate="A" pin="CLK"/>
<label x="27.94" y="111.76" size="1.778" layer="95"/>
</segment>
</net>
<net name="EXT33" class="0">
<segment>
<pinref part="JP3" gate="A" pin="12"/>
<wire x1="-12.7" y1="-27.94" x2="0" y2="-27.94" width="0.1524" layer="91"/>
<label x="-5.08" y="-27.94" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="33.02" y1="81.28" x2="43.18" y2="81.28" width="0.1524" layer="91"/>
<label x="35.56" y="81.28" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="5D"/>
</segment>
<segment>
<wire x1="33.02" y1="-7.62" x2="43.18" y2="-7.62" width="0.1524" layer="91"/>
<label x="35.56" y="-7.62" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="5D"/>
</segment>
</net>
<net name="EXT30" class="0">
<segment>
<wire x1="43.18" y1="86.36" x2="33.02" y2="86.36" width="0.1524" layer="91"/>
<label x="35.56" y="86.36" size="1.778" layer="95"/>
<pinref part="IC2" gate="A" pin="3D"/>
</segment>
<segment>
<wire x1="43.18" y1="-2.54" x2="33.02" y2="-2.54" width="0.1524" layer="91"/>
<label x="35.56" y="-2.54" size="1.778" layer="95"/>
<pinref part="IC4" gate="A" pin="3D"/>
</segment>
<segment>
<wire x1="-12.7" y1="-25.4" x2="0" y2="-25.4" width="0.1524" layer="91"/>
<label x="-5.08" y="-25.4" size="1.778" layer="95"/>
<pinref part="JP3" gate="A" pin="11"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
