<?xml version="1.0"?>

-<xsl:stylesheet xmlns:math="http://exslt.org/math" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output encoding="UTF-8" indent="yes" method="xml"/>


-<xsl:template match="/testResults">

<xsl:variable select="./httpSample/@t" name="times"/>

<xsl:variable select="./httpSample/assertionResult/failureMessage" name="failures"/>

<xsl:variable select="1000" name="threshold"/>


-<testsuite>


-<xsl:attribute name="tests">

<xsl:value-of select="count($times)"/>

</xsl:attribute>


-<xsl:attribute name="failures">

<xsl:value-of select="count($failures)"/>

</xsl:attribute>


-<testcase>

<xsl:variable select="sum($times) div count($times)" name="avg-time"/>

<xsl:attribute name="name">Average Response Time</xsl:attribute>


-<xsl:attribute name="time">

<xsl:value-of select="format-number($avg-time div 1000,'#.##')"/>

</xsl:attribute>


-<xsl:if test="$avg-time > $threshold">


-<failure>
Average response time of 
<xsl:value-of select="format-number($avg-time,'#.##')"/>
exceeds 
<xsl:value-of select="$threshold"/>
ms threshold.
</failure>

</xsl:if>

</testcase>


-<testcase>

<xsl:variable select="count($times[. > $threshold])" name="exceeds-threshold"/>

<xsl:attribute name="name">Max Response Time</xsl:attribute>


-<xsl:attribute name="time">

<xsl:value-of select="math:max($times) div 1000"/>

</xsl:attribute>


-<xsl:if test="$exceeds-threshold > count($times) * 0.1">


-<failure>

<xsl:value-of select="format-number($exceeds-threshold div count($times) * 100,'#.##')"/>
% of requests exceed 
<xsl:value-of select="$threshold"/>
ms threshold.
</failure>

</xsl:if>

</testcase>

</testsuite>

</xsl:template>

</xsl:stylesheet>