<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="tei:idno[contains(., 'http://pmb.acdh.oeaw.ac.at/apis/api2/entity/')][1]">
        <xsl:variable name="api2" select="replace(substring-after(., 'http://pmb.acdh.oeaw.ac.at/apis/api2/entity/'), '/', '')"/>
        <xsl:choose>
            <xsl:when test="(following-sibling::tei:idno[@subtype='pmb' and contains(.,$api2)][1])">
                <check/>
            </xsl:when>
            <xsl:otherwise>
                 <wrong><xsl:value-of select="."/></wrong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>