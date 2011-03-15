<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- 
        ////////////////////////////    Workers Ninja - Recursive HTML Source Manipulation
        //    ///////////////    ///    ==================================================
        ///    /////////////    ////    
        ////    ///// /////    /////    
        /////    ///   ///    //////    
        //////    /     /    ///////    
        ///////             ////////    
        ////////    //     /////////    
        /////////  ////   //////////    
        ////////////////////////////    
        
        Copyright® The Workers Ltd. 
    --> 
	
	
    <!-- TMEPLATE ///////////////////////////////////////////////////////// -->
    <!-- turns user@domain.com into domain.com[at]user -->
    <xsl:template name="mailscramble" match="@href[contains(., '@')]" mode="template-engine">
        <xsl:param name="this"/>
        <xsl:param name="email">
           <xsl:choose>
               <xsl:when test="substring-after(., 'mailto:')">
                   <xsl:value-of select="substring-after(., 'mailto:')"/>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:value-of select="."/>
               </xsl:otherwise>
           </xsl:choose>
        </xsl:param>
        
        <xsl:variable name="user" select="substring-before($email, '@')"/>
        <xsl:variable name="domain" select="substring-after($email, '@')"/>
        <xsl:attribute name="href">
        	<xsl:value-of select="concat($domain,'-at-', $user)"/>
        </xsl:attribute>
    </xsl:template>
    
     

</xsl:stylesheet>