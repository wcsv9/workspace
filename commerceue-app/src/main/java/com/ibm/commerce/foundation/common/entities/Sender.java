//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.11.16 at 11:14:39 AM CST 
//


package com.ibm.commerce.foundation.common.entities;

import com.ibm.commerce.copyright.IBMCopyright;



/**
 * Identifies the sender of the given BOD instance
 * 
 * <p>Java class for Sender complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Sender">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{http://www.openapplications.org/oagis/9}LogicalID" minOccurs="0"/>
 *         &lt;element ref="{http://www.openapplications.org/oagis/9}ComponentID" minOccurs="0"/>
 *         &lt;element ref="{http://www.openapplications.org/oagis/9}TaskID" minOccurs="0"/>
 *         &lt;element ref="{http://www.openapplications.org/oagis/9}ReferenceID" minOccurs="0"/>
 *         &lt;element ref="{http://www.openapplications.org/oagis/9}ConfirmationCode" minOccurs="0"/>
 *         &lt;element ref="{http://www.openapplications.org/oagis/9}AuthorizationID" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
public class Sender {

	/**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    protected Identifier logicalID;
    protected Identifier componentID;
    protected Identifier taskID;
    protected Identifier referenceID;
    protected ConfirmationResponseCode confirmationCode;
    protected Identifier authorizationID;

    /**
     * Gets the value of the logicalID property.
     * 
     * @return
     *     possible object is
     *     {@link Identifier }
     *     
     */
    public Identifier getLogicalID() {
        return logicalID;
    }

    /**
     * Sets the value of the logicalID property.
     * 
     * @param value
     *     allowed object is
     *     {@link Identifier }
     *     
     */
    public void setLogicalID(Identifier value) {
        this.logicalID = value;
    }

    /**
     * Gets the value of the componentID property.
     * 
     * @return
     *     possible object is
     *     {@link Identifier }
     *     
     */
    public Identifier getComponentID() {
        return componentID;
    }

    /**
     * Sets the value of the componentID property.
     * 
     * @param value
     *     allowed object is
     *     {@link Identifier }
     *     
     */
    public void setComponentID(Identifier value) {
        this.componentID = value;
    }

    /**
     * Gets the value of the taskID property.
     * 
     * @return
     *     possible object is
     *     {@link Identifier }
     *     
     */
    public Identifier getTaskID() {
        return taskID;
    }

    /**
     * Sets the value of the taskID property.
     * 
     * @param value
     *     allowed object is
     *     {@link Identifier }
     *     
     */
    public void setTaskID(Identifier value) {
        this.taskID = value;
    }

    /**
     * Gets the value of the referenceID property.
     * 
     * @return
     *     possible object is
     *     {@link Identifier }
     *     
     */
    public Identifier getReferenceID() {
        return referenceID;
    }

    /**
     * Sets the value of the referenceID property.
     * 
     * @param value
     *     allowed object is
     *     {@link Identifier }
     *     
     */
    public void setReferenceID(Identifier value) {
        this.referenceID = value;
    }

    /**
     * Gets the value of the confirmationCode property.
     * 
     * @return
     *     possible object is
     *     {@link ConfirmationResponseCode }
     *     
     */
    public ConfirmationResponseCode getConfirmationCode() {
        return confirmationCode;
    }

    /**
     * Sets the value of the confirmationCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link ConfirmationResponseCode }
     *     
     */
    public void setConfirmationCode(ConfirmationResponseCode value) {
        this.confirmationCode = value;
    }

    /**
     * Gets the value of the authorizationID property.
     * 
     * @return
     *     possible object is
     *     {@link Identifier }
     *     
     */
    public Identifier getAuthorizationID() {
        return authorizationID;
    }

    /**
     * Sets the value of the authorizationID property.
     * 
     * @param value
     *     allowed object is
     *     {@link Identifier }
     *     
     */
    public void setAuthorizationID(Identifier value) {
        this.authorizationID = value;
    }

}
