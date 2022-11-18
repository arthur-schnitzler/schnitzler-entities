<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="https://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="berufe"
        select="document('berufe.xml')"/>
    <xsl:key name="berufe-lookup-female" match="row" use="Name_female"/>
    <xsl:key name="berufe-lookup-male" match="row" use="Name_male"/>
    
    <xsl:template match="tei:person[not(tei:sex/@value='male' or tei:sex/@value='female')]">
        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|*[not(name()='sex')]"/>
            <xsl:for-each select="tei:occupation">
                <xsl:choose>
                    <xsl:when test="key('berufe-lookup-female', ., $berufe)">
                        <xsl:element name="sex" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="value">
                                <xsl:text>female</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
            <xsl:for-each select="tei:occupation">
                <xsl:choose>
                    <xsl:when test="key('berufe-lookup-male', ., $berufe)">
                        <xsl:element name="sex" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="value">
                                <xsl:text>male</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
            
            
            
        </xsl:element>
        
        
        
    </xsl:template>   
    
    
   
    
    
    
    
</xsl:stylesheet>
