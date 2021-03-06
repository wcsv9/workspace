<?xml version="1.0" encoding="UTF-8"?>

<!--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2015 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- handles purchase condition -->
	<xsl:template name="PurchaseConditionTemplate" match="/">
		<PurchaseCondition impl="com.ibm.commerce.marketing.promotion.condition.FreeGiftPurchaseCondition">
			<BaseItemSelection>
				<Quantity><xsl:value-of select="PromotionData/Elements/PurchaseCondition/Data/BaseItemQuantity" /></Quantity>
				<FilterChain impl="com.ibm.commerce.marketing.promotion.condition.FilterChain">
					<Filter impl="com.ibm.commerce.marketing.promotion.condition.MultiSKUFilter">
						<xsl:for-each select="PromotionData/Elements/PurchaseCondition/IncludeCatalogEntryIdentifier">
							<IncludeCatEntryKey>
								<xsl:call-template name="CatalogEntryKeyTemplate">
									<xsl:with-param name="dn" select="Data/DN" />
									<xsl:with-param name="sku" select="Data/SKU" />
								</xsl:call-template>
							</IncludeCatEntryKey>
						</xsl:for-each>
						<xsl:for-each select="PromotionData/Elements/PurchaseCondition/ExcludeCatalogEntryIdentifier">
							<ExcludeCatEntryKey>
								<xsl:call-template name="CatalogEntryKeyTemplate">
									<xsl:with-param name="dn" select="Data/DN" />
									<xsl:with-param name="sku" select="Data/SKU" />
								</xsl:call-template>
							</ExcludeCatEntryKey>
						</xsl:for-each>
					</Filter>
					<xsl:choose>
						<xsl:when test="PromotionData/Elements/PurchaseCondition/CatalogEntryAttributeRule">
						<!-- Only populate when there are attributes -->
							<Filter
								impl="com.ibm.commerce.marketing.promotion.condition.CatalogEntryAttributeFilter">
								<AssociatedLanguage><xsl:value-of select="PromotionData/Elements/PurchaseCondition/Data/Language" /></AssociatedLanguage>
								<xsl:choose>
									<xsl:when test="PromotionData/Elements/PurchaseCondition/Data/CatalogEntryAttributeRuleCaseSensitive">
										<CaseSensitive><xsl:value-of select="PromotionData/Elements/PurchaseCondition/Data/CatalogEntryAttributeRuleCaseSensitive" /></CaseSensitive>
									</xsl:when>
									<xsl:otherwise>
										<CaseSensitive>false</CaseSensitive>
									</xsl:otherwise> 
								</xsl:choose>
								<SupportAttributeWithNoAssociatedLanguage>true</SupportAttributeWithNoAssociatedLanguage>
								<xsl:for-each select="PromotionData/Elements/PurchaseCondition/CatalogEntryAttributeRule">
									<xsl:call-template name="CatalogEntryAttributeRuleTemplate">
										<xsl:with-param name="attributeRule" select="." />
									</xsl:call-template>	
								</xsl:for-each>					
							</Filter>
						</xsl:when>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="PromotionData/Elements/PurchaseCondition/IncludePaymentTypeIdentifier">
							<xsl:choose>
								<xsl:when test="PromotionData/Elements/PurchaseCondition/IncludePaymentTypeIdentifier/Data/PaymentType != 'Any'">
									<Filter impl="com.ibm.commerce.marketing.promotion.condition.PaymentTypeFilter">
										<IncludePaymentType>
											<PaymentMethodName><xsl:value-of select="PromotionData/Elements/PurchaseCondition/IncludePaymentTypeIdentifier/Data/PaymentType" /></PaymentMethodName>
										</IncludePaymentType>
									</Filter>
								</xsl:when>
							</xsl:choose>						
						</xsl:when>
					</xsl:choose>	
					<xsl:choose>
						<xsl:when test="string-length(PromotionData/Elements/PurchaseCondition/IncludeShipModeIdentifier) &gt; 0">
							<Filter impl="com.ibm.commerce.marketing.promotion.condition.ShippingModeFilter">
								<DN><xsl:value-of select="PromotionData/Elements/PurchaseCondition/IncludeShipModeIdentifier/Data/DN" /></DN>
								<StoreIdentifier><xsl:value-of select="PromotionData/Elements/PurchaseCondition/IncludeShipModeIdentifier/Data/StoreIdentifier" /></StoreIdentifier>
								<Carrier><xsl:value-of select="PromotionData/Elements/PurchaseCondition/IncludeShipModeIdentifier/Data/Carrier" /></Carrier>
								<ShippingCode><xsl:value-of select="PromotionData/Elements/PurchaseCondition/IncludeShipModeIdentifier/Data/ShippingCode" /></ShippingCode>
							</Filter>
						</xsl:when>
						<xsl:otherwise>
							<Filter impl="com.ibm.commerce.marketing.promotion.condition.DummyFilter"></Filter>
						</xsl:otherwise>
					</xsl:choose>					
				</FilterChain>
			</BaseItemSelection>
			<GiftQuantity><xsl:value-of select="PromotionData/Elements/PurchaseCondition/Data/GiftQuantity" /></GiftQuantity>
			<Gift>
				<xsl:call-template name="CatalogEntryKeyTemplate">
					<xsl:with-param name="dn" select="PromotionData/Elements/PurchaseCondition/GiftCatalogEntryIdentifier/Data/DN" />
					<xsl:with-param name="sku" select="PromotionData/Elements/PurchaseCondition/GiftCatalogEntryIdentifier/Data/SKU" />
				</xsl:call-template>
			</Gift>
			<AddStrategy>1</AddStrategy>
		</PurchaseCondition>
	</xsl:template>
	<!-- handles CatalogEntryKey -->
	<xsl:template name="CatalogEntryKeyTemplate">
		<xsl:param name="dn" />
		<xsl:param name="sku" />
		<CatalogEntryKey>
			<DN><xsl:value-of select="$dn" /></DN>
			<SKU><xsl:value-of select="$sku" /></SKU>
		</CatalogEntryKey>
	</xsl:template>
	<!-- handles CatalogEntryAttributeRule  -->
	<xsl:template name="CatalogEntryAttributeRuleTemplate">
		<xsl:param name="attributeRule" />
		<AttributeRule>
			<Name><xsl:value-of select="Data/Name" /></Name>
			<DataType><xsl:value-of select="Data/DataType" /></DataType>
			<MatchingType><xsl:value-of select="Data/MatchingType" /></MatchingType>
			<xsl:for-each select="Data/Value">
				<Value><xsl:value-of select="." /></Value>
			</xsl:for-each>
		</AttributeRule>
	</xsl:template>			
</xsl:transform>
