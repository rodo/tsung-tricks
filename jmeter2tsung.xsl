<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
      method="xml"
      encoding="UTF-8"
      doctype-public="-//W3C//DTD HTML 4.01//EN"
      doctype-system="http://www.w3.org/TR/html4/strict.dtd"
      indent="yes" />

  <xsl:template match="//jmeterTestPlan">
    <session name="{@testname}" weight="1" type="ts_http">
      <xsl:for-each select="hashTree/hashTree/hashTree/hashTree/HTTPSamplerProxy">
        <request>
          <http
              url="{./stringProp[@name='HTTPSampler.path']/.}"
              method="{./stringProp[@name='HTTPSampler.method']/.}">
          </http>
        </request>
      </xsl:for-each>
    </session>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="*"/>

</xsl:stylesheet>
