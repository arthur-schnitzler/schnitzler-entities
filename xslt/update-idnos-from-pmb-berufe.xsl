<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="https://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    
    
    
    <xsl:template match="tei:publicationStmt/tei:date">
        <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:value-of select="fn:current-date()"/>
        </xsl:element>
    </xsl:template>
    
    <!-- Das holt die Person neu aus der PMB -->
    <xsl:template match="tei:listPerson/tei:person">
     <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
         <xsl:copy-of select="@*"/>
         <xsl:variable name="nummer-check">
             <xsl:value-of select="replace(@xml:id, 'person__', '')"/>
         </xsl:variable>
         
         <xsl:variable name="eintrag"
             select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/entities/tei/person/', $nummer-check))"
             as="xs:string"/>
         <xsl:choose>
             <xsl:when test="doc-available($eintrag)">
                 <xsl:copy-of select="document($eintrag)/child::person/*[name()='persName' or name()='occupation' or name()='sex']" copy-namespaces="no"/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:element name="error">
                     <xsl:attribute name="type">
                         <xsl:text>person</xsl:text>
                     </xsl:attribute>
                     <xsl:value-of select="$nummer-check"/>
                 </xsl:element>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:element>
 </xsl:template>
    
   
    
    
    
    
</xsl:stylesheet>
