//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.11.16 at 11:14:39 AM CST 
//


package com.ibm.commerce.foundation.common.entities;

import java.util.ArrayList;
import java.util.List;

import com.ibm.commerce.copyright.IBMCopyright;


/**
 * Type definition of the order item's charges.
 * 
 * <p>Java class for OrderItemCharges complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="OrderItemCharges">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="UnitPrice" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}UnitPrice" minOccurs="0"/>
 *         &lt;element name="OrderItemPrice" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}MonetaryAmount" minOccurs="0"/>
 *         &lt;element name="TotalAdjustment" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}MonetaryAmount" minOccurs="0"/>
 *         &lt;element ref="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}Adjustment" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="GenericTotal" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}GenericTotal" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="ShippingCharge" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}MonetaryAmount" minOccurs="0"/>
 *         &lt;element name="SalesTax" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}MonetaryAmount" minOccurs="0"/>
 *         &lt;element name="ShippingTax" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}MonetaryAmount" minOccurs="0"/>
 *         &lt;element ref="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}TaxByTaxCategory" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element ref="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}UserData" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="priceOverride" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *       &lt;attribute name="freeGift" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *       &lt;attribute name="isPriceForInformationOnly" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
public class OrderItemCharges {

	/**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    protected UnitPrice unitPrice;
    protected MonetaryAmount orderItemPrice;
    protected MonetaryAmount totalAdjustment;
    protected List<Adjustment> adjustment;
    protected List<GenericTotal> genericTotal;
    protected MonetaryAmount shippingCharge;
    protected MonetaryAmount salesTax;
    protected MonetaryAmount shippingTax;
    protected List<TaxByTaxCategory> taxByTaxCategory;
    protected UserData userData;
    protected Boolean priceOverride;
    protected Boolean freeGift;
    protected Boolean isPriceForInformationOnly;

    /**
     * Gets the value of the unitPrice property.
     * 
     * @return
     *     possible object is
     *     {@link UnitPrice }
     *     
     */
    public UnitPrice getUnitPrice() {
        return unitPrice;
    }

    /**
     * Sets the value of the unitPrice property.
     * 
     * @param value
     *     allowed object is
     *     {@link UnitPrice }
     *     
     */
    public void setUnitPrice(UnitPrice value) {
        this.unitPrice = value;
    }

    /**
     * Gets the value of the orderItemPrice property.
     * 
     * @return
     *     possible object is
     *     {@link MonetaryAmount }
     *     
     */
    public MonetaryAmount getOrderItemPrice() {
        return orderItemPrice;
    }

    /**
     * Sets the value of the orderItemPrice property.
     * 
     * @param value
     *     allowed object is
     *     {@link MonetaryAmount }
     *     
     */
    public void setOrderItemPrice(MonetaryAmount value) {
        this.orderItemPrice = value;
    }

    /**
     * Gets the value of the totalAdjustment property.
     * 
     * @return
     *     possible object is
     *     {@link MonetaryAmount }
     *     
     */
    public MonetaryAmount getTotalAdjustment() {
        return totalAdjustment;
    }

    /**
     * Sets the value of the totalAdjustment property.
     * 
     * @param value
     *     allowed object is
     *     {@link MonetaryAmount }
     *     
     */
    public void setTotalAdjustment(MonetaryAmount value) {
        this.totalAdjustment = value;
    }

    /**
     * The adjustments.Gets the value of the adjustment property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the adjustment property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAdjustment().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Adjustment }
     * 
     * 
     */
    public List<Adjustment> getAdjustment() {
        if (adjustment == null) {
            adjustment = new ArrayList<Adjustment>();
        }
        return this.adjustment;
    }

    /**
     * Gets the value of the genericTotal property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the genericTotal property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getGenericTotal().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link GenericTotal }
     * 
     * 
     */
    public List<GenericTotal> getGenericTotal() {
        if (genericTotal == null) {
            genericTotal = new ArrayList<GenericTotal>();
        }
        return this.genericTotal;
    }

    /**
     * Gets the value of the shippingCharge property.
     * 
     * @return
     *     possible object is
     *     {@link MonetaryAmount }
     *     
     */
    public MonetaryAmount getShippingCharge() {
        return shippingCharge;
    }

    /**
     * Sets the value of the shippingCharge property.
     * 
     * @param value
     *     allowed object is
     *     {@link MonetaryAmount }
     *     
     */
    public void setShippingCharge(MonetaryAmount value) {
        this.shippingCharge = value;
    }

    /**
     * Gets the value of the salesTax property.
     * 
     * @return
     *     possible object is
     *     {@link MonetaryAmount }
     *     
     */
    public MonetaryAmount getSalesTax() {
        return salesTax;
    }

    /**
     * Sets the value of the salesTax property.
     * 
     * @param value
     *     allowed object is
     *     {@link MonetaryAmount }
     *     
     */
    public void setSalesTax(MonetaryAmount value) {
        this.salesTax = value;
    }

    /**
     * Gets the value of the shippingTax property.
     * 
     * @return
     *     possible object is
     *     {@link MonetaryAmount }
     *     
     */
    public MonetaryAmount getShippingTax() {
        return shippingTax;
    }

    /**
     * Sets the value of the shippingTax property.
     * 
     * @param value
     *     allowed object is
     *     {@link MonetaryAmount }
     *     
     */
    public void setShippingTax(MonetaryAmount value) {
        this.shippingTax = value;
    }

    /**
     * The tax amount for each tax category.Gets the value of the taxByTaxCategory property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the taxByTaxCategory property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getTaxByTaxCategory().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TaxByTaxCategory }
     * 
     * 
     */
    public List<TaxByTaxCategory> getTaxByTaxCategory() {
        if (taxByTaxCategory == null) {
            taxByTaxCategory = new ArrayList<TaxByTaxCategory>();
        }
        return this.taxByTaxCategory;
    }

    /**
     * The user data area.
     * 
     * @return
     *     possible object is
     *     {@link UserData }
     *     
     */
    public UserData getUserData() {
        return userData;
    }

    /**
     * Sets the value of the userData property.
     * 
     * @param value
     *     allowed object is
     *     {@link UserData }
     *     
     */
    public void setUserData(UserData value) {
        this.userData = value;
    }

    /**
     * Gets the value of the priceOverride property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isPriceOverride() {
        return priceOverride;
    }

    /**
     * Sets the value of the priceOverride property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setPriceOverride(Boolean value) {
        this.priceOverride = value;
    }

    /**
     * Gets the value of the freeGift property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isFreeGift() {
        return freeGift;
    }

    /**
     * Sets the value of the freeGift property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setFreeGift(Boolean value) {
        this.freeGift = value;
    }

    /**
     * Gets the value of the isPriceForInformationOnly property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isIsPriceForInformationOnly() {
        return isPriceForInformationOnly;
    }

    /**
     * Sets the value of the isPriceForInformationOnly property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setIsPriceForInformationOnly(Boolean value) {
        this.isPriceForInformationOnly = value;
    }

}
