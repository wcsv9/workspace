//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.11.16 at 11:14:39 AM CST 
//


package com.ibm.commerce.order.entities;

import com.ibm.commerce.copyright.IBMCopyright;
import com.ibm.commerce.foundation.common.entities.UserData;



/**
 * Type definition of the order's status.
 * 
 * <p>Java class for OrderStatus complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="OrderStatus">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Status" type="{http://www.ibm.com/xmlns/prod/commerce/9/order}OrderLifeCycleStatusType" minOccurs="0"/>
 *         &lt;element name="BuyerApprovalStatus" type="{http://www.ibm.com/xmlns/prod/commerce/9/order}BuyerApprovalStatusType" minOccurs="0"/>
 *         &lt;element ref="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}UserData" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="prepareIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *       &lt;attribute name="editable" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *       &lt;attribute name="locked" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *       &lt;attribute name="blocked" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
public class OrderStatus {

	/**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    protected String status;
    protected String buyerApprovalStatus;
    protected UserData userData;
    protected Boolean prepareIndicator;
    protected Boolean editable;
    protected Boolean locked;
    protected Boolean blocked;

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStatus(String value) {
        this.status = value;
    }

    /**
     * Gets the value of the buyerApprovalStatus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBuyerApprovalStatus() {
        return buyerApprovalStatus;
    }

    /**
     * Sets the value of the buyerApprovalStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBuyerApprovalStatus(String value) {
        this.buyerApprovalStatus = value;
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
     * Gets the value of the prepareIndicator property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isPrepareIndicator() {
        return prepareIndicator;
    }

    /**
     * Sets the value of the prepareIndicator property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setPrepareIndicator(Boolean value) {
        this.prepareIndicator = value;
    }

    /**
     * Gets the value of the editable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isEditable() {
        return editable;
    }

    /**
     * Sets the value of the editable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setEditable(Boolean value) {
        this.editable = value;
    }

    /**
     * Gets the value of the locked property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isLocked() {
        return locked;
    }

    /**
     * Sets the value of the locked property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setLocked(Boolean value) {
        this.locked = value;
    }

    /**
     * Gets the value of the blocked property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isBlocked() {
        return blocked;
    }

    /**
     * Sets the value of the blocked property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setBlocked(Boolean value) {
        this.blocked = value;
    }

}
