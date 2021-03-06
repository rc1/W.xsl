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
	
	
	<!-- 	    
	    # Overview
	    A set of recursive templates to iterate through an HTML source fragment
	    replacing stuff.
	    
	    ### Usage
	    DO this, do that.
	    
	    Parameters
	    
	    ### Param 1
	    Does this and that
	    
	    ### Param 2
	    Does something else
	    
	    
	    Copyright © The Workers Ltd.  
	    [theworkers.net][w]
	    [io@theworkers.net][io]
	    
	    [w]: http://theworkers.net/
	    [io]: mailto:io@theworkers.net
	-->
    
	<xsl:template match="*" mode="template-engine" >
		<xsl:param name="this" select="false()"/>
		<xsl:param name="i" select="false()"/>
		<xsl:element name="{name()}">
			<xsl:apply-templates select="* | @* | text()" mode="template-engine">
				<xsl:with-param name="this" select="$this"/>
				<xsl:with-param name="i" select="$i"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="@*" mode="template-engine" >
		<xsl:attribute name="{name(.)}">
			<xsl:value-of select="." />
		</xsl:attribute>
	</xsl:template>   

</xsl:stylesheet>