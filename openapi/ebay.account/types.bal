// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.ebay.com/identity/v1/oauth2/token";
|};

# Complex type that that gets populated with a response containing a fulfillment policy.
public type SetFulfillmentPolicyResponse record {
    # The CategoryTypeEnum value to which this policy applies. This container is used to discern accounts that sell motor vehicles from those that do not. Restriction: Currently, each policy can be set to only one categoryTypes value at a time.
    CategoryType[] categoryTypes?;
    # An optional seller-defined description of the fulfillment policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # If set to true, the seller offers freight shipping. Freight shipping can be used for large items over 150 lbs.
    boolean freightShipping?;
    # A unique eBay-assigned ID for a fulfillment policy. This ID is generated when the policy is created.
    string fulfillmentPolicyId?;
    # If set to true, the seller has opted-in to the Global Shipping Program and eBay automatically sets the international shipping service options to International Priority Shipping. If the value of globalShipping is false, the seller is responsible for specifying one or more international shipping service options if they want to ship internationally.
    boolean globalShipping?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration handlingTime?;
    # If set to true, no shipping is offered by this policy and the seller offers only local pickup of the item (normally from a non-business location). This option is most often used for customer-to-customer sales and if set, costType should be set to NOT_SPECIFIED.
    boolean localPickup?;
    # The ID of the eBay marketplace to which this fulfillment policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this fulfillment policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # If set to true, the seller offers the &quot;Click and Collect&quot; option. Currently, &quot;Click and Collect&quot; is available only to large retail merchants the eBay AU and UK marketplaces.
    boolean pickupDropOff?;
    # A list that defines the seller's shipping configurations for DOMESTIC and INTERNATIONAL order shipments. The list has a single element if the seller ships to only domestic locations. If the seller also ships internationally, a second element defines their international shipping options. Shipping options configure the high-level shipping settings that apply to orders, such as flat-rate or calculated shipping, and any rate tables the seller wants to associate with the shipping services. Each shippingOption element has a shippingServices container that defines the list of shipping services (domestic or international) offered with this fulfillment policy.
    ShippingOption[] shippingOptions?;
    # This complex type contains the regionIncluded and regionExcluded fields, which indicate the areas to where the seller does and doesn't ship. Normally a seller ships to as many areas as possible using both DOMESTIC and INTERNATIONAL shipping options, and they don't have a need to exclude any regions from their ship-to locations. Here, there's no reason to set regionExcluded fields. However, it makes sense to set the regionExcluded field when a seller wants to exclude a small area that's within a larger area they service. For example, suppose a seller indicates they ship 'Worldwide', but for some reason must exclude a specific country, or world region. Note: Configuring the shipToLocations is tricky because the regionIncluded and regionExcluded fields are valid in different parts of the schema and their allowable settings vary upon the context. For details on setting these fields, see .
    RegionSet shipToLocations?;
    # A list of warnings that were generated during the processing of the request. This field normally returns empty, which indicates the request did not generate any warnings.
    Error[] warnings?;
};

# The response payload for payment policy requests.
public type PaymentPolicyResponse record {
    # This field is for future use.
    string href?;
    # This field is for future use.
    int 'limit?;
    # This field is for future use.
    string next?;
    # This field is for future use.
    int offset?;
    # This field is for future use.
    string prev?;
    # The total number of items retrieved in the result set. If no items are found, this field is returned with a value of 0.
    int total?;
    # A list of the seller's payment policies.
    PaymentPolicy[] paymentPolicies?;
};

# This is the base response type of the getKYC method.
public type KycResponse record {
    # This array contains one or more KYC checks required from a managed payments seller. The seller may need to provide more documentation and/or information about themselves, their company, or the bank account they are using for seller payouts. If no KYC checks are currently required from the seller, this array is not returned, and the seller only receives a 204 No Content HTTP status code.
    KycCheck[] kycChecks?;
};

# This root container defines a seller's payment policy for a specific marketplace and category type. Used when creating or updating a payment policy, paymentPolicyRequest encapsulates a seller's terms for how buyers can pay for the items they buy. While each seller must define at least one payment policy for every marketplace into which they sell, sellers can define multiple payment policies for a single marketplace by specifying different configurations for the unique policies. A successful call returns a paymentPolicyId, plus the Location response header contains the URI to the resource. Policy instructions can be localized by providing a locale in the Content-Language HTTP request header. For example: Content-Language: de-DE. Tip: For more on using business policies, see eBay business policies.
public type PaymentPolicyRequest record {
    # The CategoryTypeEnum value to which this policy applies. This container is used to discern accounts that sell motor vehicles from those that do not. Restriction: Currently, each policy can be set to only one categoryTypes value at a time.
    CategoryType[] categoryTypes?;
    # A container that describes the details of a deposit. Used only with motor listings.
    Deposit deposit?;
    # An optional seller-defined description of the payment policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration fullPaymentDueIn?;
    # If set to true, payment is due upon receipt (eBay generates a receipt when the buyer agrees to purchase an item). This boolean must be set in the payment policy if the seller wants to create a listing that has an immediate payment requirement. The seller can change the immediate payment requirement at any time during the life cycle of a listing. The following must be true before a seller can apply an immediate payment requirement to an item: The seller must have a PayPal Business account. The Buy It Now price cannot be higher than $60,000 USD. The eBay marketplace on which the item is listed must support PayPal payments. The listing type must be fixed-price, or an auction with a Buy It Now option. Note: This container can be used for sellers who opt-in to the managed payments program, but some requirements do not apply.To enable the immediate payment requirement, the seller must also perform the following actions via API calls: Provide a valid paymentMethods.recipientAccountReference.referenceId value. Offer PayPal as the only payment method for the item(s). Specify all related costs to the buyer (because the buyer is not able to use the Buyer Request Total feature in an immediate payment listing); these costs include flat-rate shipping costs for each domestic and international shipping service offered, package handling costs, and any shipping surcharges. Include and set the shippingProfileDiscountInfo container values if you are going to use promotional shipping discounts.For more information, see the Understanding immediate payment Help page. Note: Listings created with the Inventory API must reference a payment policy that has immediatePay set to true. Items listed with the Inventory API must also be fixed-price, good-till-canceled (GTC) listings where PayPal is the only supported payment method (paymentMethod must be set to PAYPAL).Default: False
    boolean immediatePay?;
    # The ID of the eBay marketplace to which this payment policy applies. If this value is not specified, the value defaults to the seller's eBay registration site. Note: A limited number of sellers, on a limited number of eBay marketplaces, are currently opted-in to the eBay managed payments program. To view the eBay marketplaces where managed payments are currently supported, see the managed payments landing page. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this payment policy. Names must be unique for policies assigned to the same marketplace. Note: eBay will create a new payment policy for sellers who opt-in to the managed payments program.Max length: 64
    string name?;
    # A free-form string field that allows sellers to add detailed payment instructions to their listings. The payment instructions appear on eBay's View Item and Checkout pages. eBay recommends sellers use this field to clarify payment policies for motor vehicle listings on eBay Motors. For example, sellers can include the specifics on the deposit (if required), pickup/delivery arrangements, and full payment details on the vehicle. The field allows only 500 characters as input, but due to the way the eBay web site UI treats characters, this field can return more than 500 characters in the response. For example, characters like &amp; and ' (ampersand and single quote) count as 5 characters each. Restriction: This container is not supported for sellers who opt-in to the managed payments program. Max length: 1000
    string paymentInstructions?;
    # A list of the payment methods accepted by the seller. Important: Do not populate this container if you are opted-in to managed payments. To verify whether or not you are opted-in to the managed payments program, call getPaymentsProgram. If you are not opted-in to the managed payments program, each payment policy you create must specify at least one payment method. In addition, if you are not opted-in to managed payments, the listings you create with the Inventory API must reference a payment policy that has this value set to PAYPAL (currently, the Inventory API supports only fixed-prince GTC items with immediate pay (which required payments to be made via PayPal). In order for a buyer to make a full payment on a US or CA motor vehicle, the payment policy must specify at least one of the following as a payment method: CashOnPickup LoanCheck MOCC (money order or cashier's check) PaymentSeeDescription (payment instructions are in the paymentInstructions field) PersonalCheck Note: Each eBay marketplace supports and requires its own set of payment methods and not all marketplaces support the same set of payment methods. Check the specifics of the marketplaces where you list items to ensure your payment policies meet the payment method requirements needed for any specific listing.
    PaymentMethod[] paymentMethods?;
};

# The category type discerns whether the policy covers the sale of motor vehicles (via eBay Motors), or the sale of everything except motor vehicles. Each business policy can be associated with either or both categories ('MOTORS_VEHICLES' and 'ALL_EXCLUDING_MOTORS_VEHICLES'); however,the 'MOTORS_VEHICLES' category type is not valid for return policies&ndash;return policies cannot be used with motor vehicle listings.
public type CategoryType record {
    # Specifies the default policy for a marketplaceId and categoryTypes.name pair. Sellers can create multiple policies for any marketplaceId and categoryTypes.name combination. For example, you can create multiple fulfillment policies for one marketplace, where they all target the same category type name. However, only one policy can be the default for any marketplaceId and name combination, and eBay designates the first policy created for a combination as the default. If set to true, this policy is the default policy for the associated categoryTypes.name and marketplaceId pair. Note: eBay considers the status of this field only when you create listings through the Web flow. If you create listings using the APIs, you must specifically set the policies you want applied to a listing in the payload of the call you use to create the listing. If you use the Web flow to create item listings, eBay uses the default policy for the marketplace and category type specified, unless you override the default. For more on default policies, see Changing the default policy for a category type.
    boolean default?;
    # The category type to which the policy applies (motor vehicles or non-motor vehicles). Restrictions: The MOTORS_VEHICLES category type is not valid for return policies. eBay flows do not support the return of motor vehicles. Only the ALL_EXCLUDING_MOTORS_VEHICLES category type is supported for sellers who opt-in to the managed payments program. Managed payments does not currently support the sale of motor vehicles. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:CategoryTypeEnum'>eBay API documentation</a>
    string name?;
};

# This root container defines a seller's return policy for a specific marketplace and category type. Used when creating or updating a return policy, returnPolicyRequest encapsulates a seller's terms for how buyers can return items. While each seller must define at least one payment policy for every marketplace into which they sell, sellers can define multiple payment policies for a single marketplace by specifying different configurations for the unique policies. A successful call returns a paymentPolicyId, plus the Location response header contains the URI to the resource. Use the Metadata API method to determine which categories in the marketplace(s) require you to provide a return policy. Also note that some marketplaces require you to provide a specific return policy for vehicle listings. Policy instructions can be localized by providing a locale in the Content-Language HTTP request header. For example: Content-Language: de-DE. Tip: For more on using business policies, see eBay business policies.
public type ReturnPolicyRequest record {
    # For return policies, this field can be set to only ALL_EXCLUDING_MOTORS_VEHICLES (returns on motor vehicles are not processed through eBay flows.) Default: ALL_EXCLUDING_MOTORS_VEHICLES (for return policies only)
    CategoryType[] categoryTypes?;
    # An optional seller-defined description of the return policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value supplied in this field is ignored, it is neither read nor returned. If set to true, the seller offers an Extended Holiday Returns policy for their listings. IMPORTANT: Extended Holiday Returns is a seasonally available feature that is offered on some eBay marketplaces. To see if the feature is enabled in any given year, check the Returns on eBay page before the holiday season begins. If the feature is not enabled for the season, this field is ignored. The extended holiday returns period is defined by three dates: The start date = start of November. The purchase cutoff date = end of the year. The end date = end of January. The above dates may vary by a few days each year. Sellers are notified of the current dates on their eBay marketplace before the holiday period starts. Sellers can specify Extended Holiday Returns (as well as their regular non-holiday returns period) for chosen listings at any time during the year. The Extended Holiday Returns offer is not visible in listings until the start date of current year's holiday returns period, at which point it overrides the non-holiday returns policy. Buyers can see the Extended Holiday Returns offer in listings displayed through the purchase cutoff date and are able to return those purchases until the end date of the period. After the purchase cutoff date, the Extended Holiday Returns offer automatically disappears from the listings and the seller's non-holiday returns period reappears. Purchases made from that point on are subject to the non-holiday returns period, while purchases made before the cutoff date still have until the end of the period to return under the program. If the value of holidayReturns is false for an item, the return period specified by the returnsWithinOption field applies, regardless of the purchase date. If the item is listed with a policy of no returns, holidayReturns is automatically reset to false.
    boolean extendedHolidayReturnsOffered?;
    # This type defines the fields for a seller's international return policy. If a seller does not populate the fields in this complex type, the international return policy defaults to the return policy set for domestic returns.
    InternationalReturnOverrideType internationalOverride?;
    # The ID of the eBay marketplace to which this return policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this return policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # Important! this field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value other than MONEY_BACK will be treated as MONEY_BACK (although for a period of time, eBay will store and return the legacy values to preserve backwards compatibility). Indicates the method the seller uses to compensate the buyer for returned items. The return method specified applies only to remorse returns. Note that each eBay marketplace can support different sets of refund methods. Also, each eBay marketplace has a default setting for this value and if you do not specifically set this value, sellers are obligated to honor the setting that displays in their listings. Call GeteBayDetails in the Trading API to see what refund methods the marketplaces you sell into support. We recommend you set this field to the value of your preferred refund method and that you use the description field to detail the seller's return policy (such as indicating how quickly the seller will process a refund, whether the seller must receive the item before processing a refund, and other similar useful details). You cannot modify this value in a Revise item call if (1) the listing has bids or (2) the listing ends within 12 hours. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:RefundMethodEnum'>eBay API documentation</a>
    string refundMethod?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value supplied in this field is ignored, it is neither read nor returned. Sellers who accept returns should include this field if they charge buyers a restocking fee when items are returned. A restocking fee comes into play only when an item is returned due to buyer remorse and/or a purchasing mistake, but sellers cannot charge a restocking fee for SNAD-related returns. The total amount returned to the buyer is reduced by the cost of the item multiplied by the percentage indicated by this field. Allowable restocking fee values are: 0.0: No restocking fee is charged to the buyer 10.0: 10 percent of the item price is charged to the buyer 15.0: 15 percent of the item price is charged to the buyer 20.0: Up to 20 percent of the item price is charged to the buyer
    string restockingFeePercentage?;
    # Important! This field is being deprecated on many marketplaces. Once deprecated, this field will be ignored on marketplaces where it is not supported and it will neither be read nor returned. This optional field contains the seller's detailed explanation for their return policy and is displayed in the Return Policy section of the View Item page. This field is valid in only the following marketplaces (the field is otherwise ignored): Germany (DE) Spain (ES) France (FR) Italy (IT) Where valid, sellers can use this field to add details about their return policies. eBay uses this text string as-is in the Return Policy section of the View Item page. Avoid HTML and avoid character entity references (such as &amp;amp;pound; or &amp;amp;#163;). To include special characters in the return policy description, use the literal UTF-8 or ISO-8559-1 character (e.g. &amp;#163;). Max length: 5000 (8000 for DE)
    string returnInstructions?;
    # Valid in the US marketplace only, this optional field indicates additional services (other than money-back) that sellers can offer buyers for remorse returns. As of version 1.2.0, the only accepted value for this field is REPLACEMENT. This field is valid in only the US marketplace, any supplied value is ignored in other marketplaces. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnMethodEnum'>eBay API documentation</a>
    string returnMethod?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration returnPeriod?;
    # If set to true, the seller accepts returns. Call the getReturnPolicies in the Metadata API to see what categories require returns to be offered for listings in each category. Also, note that some European marketplaces (for example, UK, IE, and DE) require sellers to accept returns for fixed-price items and auctions listed with Buy It Now. For details, see Returns and the Law (UK). Note:Top-Rated sellers must accept item returns and the handlingTime should be set to zero days or one day for a listing to receive a Top-Rated Plus badge on the View Item or search result pages. For more information on eBay's Top-Rated seller program, see Becoming a Top Rated Seller and qualifying for Top Rated Plus benefits.
    boolean returnsAccepted?;
    # This field indicates who is responsible for paying for the shipping charges for returned items. The field can be set to either BUYER or SELLER. Depending on the return policy and specifics of the return, either the buyer or the seller can be responsible for the return shipping costs. Note that the seller is always responsible for return shipping costs for SNAD-related issues. Required if returnsAccepted is set to true. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnShippingCostPayerEnum'>eBay API documentation</a>
    string returnShippingCostPayer?;
};

# The response container for with information on a seller's shipping rate tables.
public type RateTableResponse record {
    # A list of elements that provide information on the seller-defined shipping rate tables.
    RateTable[] rateTables?;
};

# This complex type contains the regionIncluded and regionExcluded fields, which indicate the areas to where the seller does and doesn't ship. Normally a seller ships to as many areas as possible using both DOMESTIC and INTERNATIONAL shipping options, and they don't have a need to exclude any regions from their ship-to locations. Here, there's no reason to set regionExcluded fields. However, it makes sense to set the regionExcluded field when a seller wants to exclude a small area that's within a larger area they service. For example, suppose a seller indicates they ship 'Worldwide', but for some reason must exclude a specific country, or world region. Note: Configuring the shipToLocations is tricky because the regionIncluded and regionExcluded fields are valid in different parts of the schema and their allowable settings vary upon the context. For details on setting these fields, see .
public type RegionSet record {
    # A list of one or more regionsName fields that specify the areas to where a seller does not ship. Populate regionExcluded in only the top-level shipToLocations container (do not populate this field within the shippingOptions container). Normally a seller ships to as many areas as possible using both DOMESTIC and INTERNATIONAL shipping options and they don't have a need to exclude any regions from their ship-to locations. With this, there's no reason to set regionExclude fields. However, it makes sense to set the regionExcluded field when a seller wants to exclude a small area that's located within a larger area they service. For example, suppose a seller indicates they ship 'Worldwide', but for some reason must exclude a specific country, or world region, from the larger world area they ship to. To retrieve the regions you can specify in the associated regionName field, call GeteBayDetails with DetailName set to ExcludeShippingLocationDetails, then review the Location fields in the response for the strings that you can specify regionExcluded.regionName. Note that if a buyer's primary ship-to location is a region that a seller has excluded in their fulfillment policy (or if the buyer does not have a primary ship-to location), they will receive an error message if they attempt to buy or place a bid on an item that uses that fulfillment policy. For details on setting this field, see Excluding specific regions from included shipping areas.
    Region[] regionExcluded?;
    # A list of one or more regionsName fields that specify the areas to where a seller ships. Important: Populate this field only when the parent shipToLocations object is located within a shippingOptions container (that is, the parent shipTolocations object must not be the one at the top-level of the policy). Also, this field needs to be populated only when the associated shippingOptions container has optionType set to INTERNATIONAL. Withing an international shipping option, set this value to Worldwide to indicate the seller ships to all world regions. If needed, use the regionExcluded field to exclude any regions in the world to where the seller does not ship. Each eBay marketplace supports its own set of allowable shipping locations. Obtain the valid 'Ship-To Locations' for a marketplace by calling GeteBayDetails with DetailName set to ShippingLocationDetails, then review the ShippingLocation fields in the response for the strings that you can specify in the regionIncluded.regionName field. For DOMESTIC shipping options, eBay automatically uses the seller's listing country as the default regionIncluded country. For details on setting this field, see How to set up worldwide shipping. This field is always returned in the shipping policy response. Required if optionType set to INTERNATIONAL.
    Region[] regionIncluded?;
};

# The applicable sales tax rate, as a percentage of the sale amount, for a given country and sales tax jurisdiction within that country.
public type SalesTax record {
    # The country code identifying the country to which this tax rate applies. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:CountryCodeEnum'>eBay API documentation</a>
    string countryCode?;
    # A unique ID that identifies the sales tax jurisdiction to which the tax rate applies (for example a state within the United States).
    string salesTaxJurisdictionId?;
    # The sales tax rate (as a percentage of the sale) applied to sales transactions made in this country and sales tax jurisdiction.
    string salesTaxPercentage?;
    # If set to true, shipping and handling charges are taxed.
    boolean shippingAndHandlingTaxed?;
};

# A list of sales tax tables.
public type SalesTaxes record {
    # A list of sales tax tables that have been set up by a seller.
    SalesTax[] salesTaxes?;
};

# Root container that defines the fields for a seller's return policy. The returnPolicy encapsulates a seller's terms for how they handle item returns, the name and description of the policy, and the marketplace and category group(s) to which the return policy is applied. While each seller must define at least one return policy for every marketplace into which they sell, sellers can define multiple return policies for a single marketplace by specifying different configurations for the unique policies.
public type ReturnPolicy record {
    # For return policies, this field can be set to only ALL_EXCLUDING_MOTORS_VEHICLES (returns on motor vehicles are not processed through eBay flows) Default: ALL_EXCLUDING_MOTORS_VEHICLES (for return policies only)
    CategoryType[] categoryTypes?;
    # An optional seller-defined description of the return policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value supplied in this field is neither read nor returned. If set to true, the seller offers an Extended Holiday Returns policy for their listings. IMPORTANT: Extended Holiday Returns is a seasonally available feature that is offered on some eBay marketplaces. To see if the feature is enabled in any given year, check the Returns on eBay page before the holiday season begins. If the feature is not enabled for the season, this field is ignored. The extended holiday returns period is defined by three dates: The start date = start of November. The purchase cutoff date = end of the year. The end date = end of January. The above dates may vary by a few days each year. Sellers are notified of the current dates on their eBay marketplace before the holiday period starts. Sellers can specify Extended Holiday Returns (as well as their regular non-holiday returns period) for chosen listings at any time during the year. The Extended Holiday Returns offer is not visible in listings until the start date of current year's holiday returns period, at which point it overrides the non-holiday returns policy. Buyers can see the Extended Holiday Returns offer in listings displayed through the purchase cutoff date and are able to return those purchases until the end date of the period. After the purchase cutoff date, the Extended Holiday Returns offer automatically disappears from the listings and the seller's non-holiday returns period reappears. Purchases made from that point on are subject to the non-holiday returns period, while purchases made before the cutoff date still have until the end of the period to return under the program. If the value of holidayReturns is false for an item, the return period specified by the returnsWithinOption field applies, regardless of the purchase date. If the item is listed with a policy of no returns, holidayReturns is automatically reset to false.
    boolean extendedHolidayReturnsOffered?;
    # This type defines the fields for a seller's international return policy. If a seller does not populate the fields in this complex type, the international return policy defaults to the return policy set for domestic returns.
    InternationalReturnOverrideType internationalOverride?;
    # The ID of the eBay marketplace to which this return policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this return policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # Important! this field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value other than MONEY_BACK will be treated as MONEY_BACK (although for a period of time, eBay will store and return the legacy values to preserve backwards compatibility). Indicates the method the seller uses to compensate the buyer for returned items. The return method specified applies only to remorse returns. Each eBay marketplace may support different sets of refund methods and marketplaces can also have differing default values for this field. Sellers are obligated to honor the refund method displayed in their listings. Call GeteBayDetails in the Trading API to see the refund methods supported by the marketplaces you sell into. We recommend you set this field to the value of your preferred refund method and that you use the description field to detail the seller's return policy (such as indicating how quickly the seller will process a refund, whether the seller must receive the item before processing a refund, and other similar useful details). You cannot modify this value in a Revise item call if (1) the listing has bids or (2) the listing ends within 12 hours. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:RefundMethodEnum'>eBay API documentation</a>
    string refundMethod?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value supplied in this field is ignored, it is neither read nor returned. Sellers who accept returns should include this field if they charge buyers a restocking fee when items are returned. A restocking fee comes into play only when an item is returned due to buyer remorse and/or a purchasing mistake, but sellers cannot charge a restocking fee for SNAD-related returns. The total amount returned to the buyer is reduced by the cost of the item multiplied by the percentage indicated by this field. Allowable restocking fee values are: 0.0: No restocking fee is charged to the buyer 10.0: 10 percent of the item price is charged to the buyer 15.0: 15 percent of the item price is charged to the buyer 20.0: Up to 20 percent of the item price is charged to the buyer
    string restockingFeePercentage?;
    # Important! This field is being deprecated on many marketplaces. Once deprecated, this field will be ignored on marketplaces where it is not supported and it will neither be read nor returned. This optional field contains the seller's detailed explanation for their return policy and is displayed in the Return Policy section of the View Item page. This field is valid in only the following marketplaces (the field is otherwise ignored): Germany (DE) Spain (ES) France (FR) Italy (IT) Where valid, sellers can use this field to add details about their return policies. eBay uses this text string as-is in the Return Policy section of the View Item page. Avoid HTML and avoid character entity references (such as &amp;amp;pound; or &amp;amp;#163;). To include special characters in the return policy description, use the literal UTF-8 or ISO-8559-1 character (e.g. &amp;#163;). Max length: 5000 (8000 for DE)
    string returnInstructions?;
    # Valid in the US marketplace only, this optional field indicates additional services (other than money-back) that sellers can offer buyers for remorse returns. As of version 1.2.0, the only accepted value for this field is REPLACEMENT. This field is valid in only the US marketplace, any supplied value is ignored in other marketplaces. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnMethodEnum'>eBay API documentation</a>
    string returnMethod?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration returnPeriod?;
    # A unique eBay-assigned ID for this policy. This ID value is appended to the end of the Location URI that is returned as a response header when you call createReturnPolicy).
    string returnPolicyId?;
    # If set to true, the seller accepts returns. Call the getReturnPolicies in the Metadata API to see what categories require returns to be offered for listings in each category. Also, note that some European marketplaces (for example, UK, IE, and DE) require sellers to accept returns for fixed-price items and auctions listed with Buy It Now. For details, see Returns and the Law (UK). Note:Top-Rated sellers must accept item returns and the handlingTime should be set to zero days or one day for a listing to receive a Top-Rated Plus badge on the View Item or search result pages. For more information on eBay's Top-Rated seller program, see Becoming a Top Rated Seller and qualifying for Top Rated Plus benefits.
    boolean returnsAccepted?;
    # This field indicates who is responsible for paying for the shipping charges for returned items. The field can be set to either BUYER or SELLER. Depending on the return policy and specifics of the return, either the buyer or the seller can be responsible for the return shipping costs. Note that the seller is always responsible for return shipping costs for SNAD-related issues. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnShippingCostPayerEnum'>eBay API documentation</a>
    string returnShippingCostPayer?;
};

# Complex type that that gets populated with a response containing a return policy.
public type SetReturnPolicyResponse record {
    # For return policies, this field always returns ALL_EXCLUDING_MOTORS_VEHICLES (returns on motor vehicles are not processed through eBay flows.) Default: ALL_EXCLUDING_MOTORS_VEHICLES (for return policies only)
    CategoryType[] categoryTypes?;
    # An optional seller-defined description of the return policy for internal use (this value is not displayed to end users).
    string description?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value supplied in this field is ignored, it is neither read nor returned. If set to true, the seller offers an Extended Holiday Returns policy for their listings. IMPORTANT: Extended Holiday Returns is a seasonally available feature that is offered on some eBay marketplaces. To see if the feature is enabled in any given year, check the eBay Seller Center Returns on eBay page of before the holiday season begins.
    boolean extendedHolidayReturnsOffered?;
    # This type defines the fields for a seller's international return policy. If a seller does not populate the fields in this complex type, the international return policy defaults to the return policy set for domestic returns.
    InternationalReturnOverrideType internationalOverride?;
    # The ID of the eBay marketplace to which this return policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this return policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value other than MONEY_BACK will be treated as MONEY_BACK (although for a period of time, eBay will store and return the legacy values to preserve backwards compatibility). Indicates the method the seller uses to compensate the buyer for returned items. The return method specified applies only to remorse returns. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:RefundMethodEnum'>eBay API documentation</a>
    string refundMethod?;
    # Important! This field has been deprecated as of version 1.2.0, released on May 31, 2018. Any value supplied in this field is ignored, it is neither read nor returned. Optionally set by the seller, the percentage charged if the seller charges buyers a a restocking fee when items are returned due to buyer remorse and/or a purchasing mistake. The total amount charged to the buyer is the cost of the item multiplied by the percentage indicated in this field.
    string restockingFeePercentage?;
    # This field contains the seller's detailed explanation for their return policy and is displayed in the Return Policy section of the View Item page. This field is valid in only the following marketplaces (the field is otherwise ignored): Germany (DE) Spain (ES) France (FR) Italy (IT)
    string returnInstructions?;
    # This field indicates the method in which the seller handles non-money back return requests for remorse returns. This field is valid in only the US marketplace and the only valid value is REPLACEMENT. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnMethodEnum'>eBay API documentation</a>
    string returnMethod?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration returnPeriod?;
    # A unique eBay-assigned ID for a return policy. This ID is generated when the policy is created.
    string returnPolicyId?;
    # If set to true, the seller accepts returns. If set to false, this field indicates that the seller does not accept returns.
    boolean returnsAccepted?;
    # This field indicates who is responsible for paying for the shipping charges for returned items. The field can be set to either BUYER or SELLER. Depending on the return policy and specifics of the return, either the buyer or the seller can be responsible for the return shipping costs. Note that the seller is always responsible for return shipping costs for SNAD-related issues. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnShippingCostPayerEnum'>eBay API documentation</a>
    string returnShippingCostPayer?;
    # A list of warnings related to request. This field normally returns empty, which indicates the request did not generate any warnings.
    Error[] warnings?;
};

# A complex type that contains information pertaining to a shipping rate table.
public type RateTable record {
    # A two-letter ISO 3166 country code representing the eBay marketplace where an item is listed. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:CountryCodeEnum'>eBay API documentation</a>
    string countryCode?;
    # The region covered by the shipping rate table, either DOMESTIC or INTERNATIONAL. DOMESTIC indicates that the shipping rate table applies to regions within the country where an item is listed (the source country) while INTERNATIONAL indicates that the shipping rate table applies to regions outside of the country where an item is listed. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ShippingOptionTypeEnum'>eBay API documentation</a>
    string locality?;
    # The user-defined name for the shipping rate table. Sellers can access Seller Hub (or My eBay &gt; Account &gt; Site Preferences &gt; Shipping preferences) to create and assign names to their shipping rate tables.
    string name?;
    # A unique eBay-assigned ID for a seller's shipping rate table. Call getRateTables to retrieve the seller's current rate table IDs.
    string rateTableId?;
};

# A complex type that defines the available shipping services offered in the parent shippingOptions container. The shipping services specified here must be able to accommodate the optionType defined in the parent shippingOption container (either DOMESTIC or INTERNATIONAL). Tip: For more on setting up shipping services, see Setting the shipping carrier and shipping service values.
public type ShippingService record {
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount additionalShippingCost?;
    # This field is only applicable to vehicle categories on eBay Motors (US and Canada). If set to true, the buyer is responsible for picking up the vehicle. Otherwise, the seller should specify the vehicle pickup arrangements in the item description. The seller cannot modify this flag if the vehicle has bids or if the listing ends within 12 hours. Default: false
    boolean buyerResponsibleForPickup?;
    # This field is applicable for only items listed in vehicle categories on eBay Motors (US and Canada). If set to true, the buyer is responsible for the shipment of the vehicle. Otherwise, the seller should specify the vehicle shipping arrangements in the item description. The seller cannot modify this flag if the vehicle has bids or if the listing ends within 12 hours. Default: false
    boolean buyerResponsibleForShipping?;
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount cashOnDeliveryFee?;
    # If set to true, the seller offers free shipping to the buyer. This field can only be included and set to 'true' for the first domestic shipping service option specified in the shippingServices container (it is ignored if set for subsequent shipping services). The first specified shipping service option has a sortOrder value of 1 or (if the sortOrderId field is not used) it is the shipping service option that's specified first in the shippingServices container.
    boolean freeShipping?;
    # The shipping carrier, such as 'USPS', 'FedEx', 'UPS', and so on.
    string shippingCarrierCode?;
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount shippingCost?;
    # The shipping service that the shipping carrier uses to ship an item. For example, an overnight, two-day delivery, or other type of service. For details on configuring shipping services, see Setting the shipping carrier and shipping service values.
    string shippingServiceCode?;
    # This complex type contains the regionIncluded and regionExcluded fields, which indicate the areas to where the seller does and doesn't ship. Normally a seller ships to as many areas as possible using both DOMESTIC and INTERNATIONAL shipping options, and they don't have a need to exclude any regions from their ship-to locations. Here, there's no reason to set regionExcluded fields. However, it makes sense to set the regionExcluded field when a seller wants to exclude a small area that's within a larger area they service. For example, suppose a seller indicates they ship 'Worldwide', but for some reason must exclude a specific country, or world region. Note: Configuring the shipToLocations is tricky because the regionIncluded and regionExcluded fields are valid in different parts of the schema and their allowable settings vary upon the context. For details on setting these fields, see .
    RegionSet shipToLocations?;
    # This integer value controls the order that this shipping service option appears in the View Item and Checkout pages, as related to the other specified shipping service options. Sellers can specify up to four domestic shipping services (in four separate shippingService containers), so valid values are 1, 2, 3, and 4. A shipping service option with a sortOrder value of '1' appears at the top of View Item and Checkout pages. Conversely, a shipping service option with a sortOrder value of '4' appears at the bottom of the list. Sellers can specify up to five international shipping services (in five separate shippingService containers, so valid values for international shipping services are 1, 2, 3, 4, and 5. Similarly to domestic shipping service options, the sortOrder value of a international shipping service option controls the placement of that shipping service option in the View Item and Checkout pages. Set up different domestic and international services by configuring two shippingOptions containers, where you set shippingOptions.optionType to either DOMESTIC or INTERNATIONAL to indicate the area supported by the listed shipping services. If the sortOrder field is not supplied, the order of domestic and international shipping service options is determined by the order in which they are listed in the API call. Min: 1. Max: 4 (for domestic shipping service) or 5 (for international shipping service).
    int sortOrder?;
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount surcharge?;
};

# A complex type that specifies a period of time using a specified time-measurement unit.
public type TimeDuration record {
    # A time-measurement unit that specifies a singular period of time. A span of time is defined when you apply the value specified in the value field to the value specified for unit. Time-measurement units can be YEAR, MONTH, DAY, and so on. See TimeDurationUnitEnum for a complete list of possible time-measurement units. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:TimeDurationUnitEnum'>eBay API documentation</a>
    string unit?;
    # An integer that represents an amount of time, as measured by the time-measurement unit specified in the unit field.
    int value?;
};

# The response object containing the sellers status with regards to the specified payment program.
public type PaymentsProgramResponse record {
    # The ID of the eBay marketplace to which the payment policy applies. If this value is not specified in the request, the value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # This path parameter specifies the payment program whose status is returned by the call. Currently the only supported payments program is EBAY_PAYMENTS. For details on the program, see Payments Terms of Use. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:PaymentsProgramType'>eBay API documentation</a>
    string paymentsProgramType?;
    #  For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:PaymentsProgramStatus'>eBay API documentation</a>
    string status?;
    # If set to true, the seller was at one point opted-in to the associated payment program, but they later opted out of the program. A value of false indicates the seller never opted-in to the program or if they did opt-in to the program, they never opted-out of it. It's important to note that the setting of this field does not indicate the seller's current status regarding the payment program. It is possible for this field to return true while the status field returns OPTED_IN.
    boolean wasPreviouslyOptedIn?;
};

# The response payload for requests that return a list of fulfillment policies.
public type FulfillmentPolicyResponse record {
    # A list of the seller's fulfillment policies.
    FulfillmentPolicy[] fulfillmentPolicies?;
    # This field is for future use.
    string href?;
    # This field is for future use.
    int 'limit?;
    # This field is for future use.
    string next?;
    # This field is for future use.
    int offset?;
    # This field is for future use.
    string prev?;
    # The total number of items retrieved in the result set. If no items are found, this field is returned with a value of 0.
    int total?;
};

# A list of the supported seller programs.
public type Programs record {
    # A list of seller programs.
    Program[] programs?;
};

# A container that describes the details of a deposit. Used only with motor listings.
public type Deposit record {
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount amount?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration dueIn?;
    # For deposits (which are applicable to only motor listings), the paymentMethodType must be set to 'PAYPAL' and you must also populate the fields in the recipientAccountReference object. Required if your motor vehicles listing requires a deposit.
    PaymentMethod[] paymentMethods?;
};

# The payments program onboarding steps, status, and link.
public type PaymentsProgramOnboardingSteps record {
    # The name of the step in the steps array. Over time, these names are subject to change as processes change. The output sample contains example step names. Review an actual call response for updated step names.
    string name?;
    # This enumeration value indicates the status of the associated step. Note: Only one step can be IN_PROGRESS at a time. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:PaymentsProgramOnboardingStepStatus'>eBay API documentation</a>
    string status?;
    # This URL provides access to the IN_PROGRESS step.
    string webUrl?;
};

# A seller program in to which a seller can opt-in.
public type Program record {
    # A seller program in to which a seller can opt-in. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ProgramTypeEnum'>eBay API documentation</a>
    string programType?;
};

# A complex type that describes the value of a monetary amount as represented by a global currency.
public type Amount record {
    # The base currency applied to the value field to establish a monetary amount. The currency is represented as a 3-letter ISO 4217 currency code. For example, the code for the Canadian Dollar is CAD. Default: The default currency of the eBay marketplace that hosts the listing. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:CurrencyCodeEnum'>eBay API documentation</a>
    string currency?;
    # The monetary amount in the specified currency. Required in the amount type.
    string value?;
};

# A container that defines the elements of error and warning messages.
public type Error record {
    # The category type for this error or warning. It is a string that can have one of three values: Application: Indicates an exception or error occurred in the application code or at runtime. Examples include catching an exception in a service's business logic, system failures, or request errors from a dependency. Business: Used when your service or a dependent service refused to continue processing on the resource because of a business rule violation such as &quot;Seller does not ship item to Antarctica&quot; or &quot;Buyer ineligible to purchase an alcoholic item&quot;. Business errors are not syntactical input errors. Request: Used when there is anything wrong with the request, such as authentication, syntactical errors, rate limiting or missing headers, bad HTTP header values, and so on.
    string category?;
    # Name of the domain ,or primary system, of the service or application where the error occurred.
    string domain?;
    # A positive integer that uniquely identifies the specific error condition that occurred. Your application can use error codes as identifiers in your customized error-handling algorithms.
    int errorId?;
    # Identifies specific request elements associated with the error, if any. inputRefId's response is format specific. For JSON, use JSONPath notation.
    string[] inputRefIds?;
    # A more detailed explanation of the error than given in the message error field.
    string longMessage?;
    # Information on how to correct the problem, in the end user's terms and language where applicable. Its value is at most 50 characters long. If applicable, the value is localized in the end user's requested locale.
    string message?;
    # Identifies specific response elements associated with the error, if any. Path format is the same as inputRefId.
    string[] outputRefIds?;
    # This optional list of name/value pairs that contain context-specific ErrorParameter objects, with each item in the list being a parameter (or input field name) that caused an error condition. Each ErrorParameter object consists of two fields, a name and a value.
    ErrorParameter[] parameters?;
    # If present, indicates the subsystem in which the error occurred.
    string subdomain?;
};

# This type is used to provide details about any KYC check that is applicable to the managed payments seller.
public type KycCheck record {
    # The enumeration value returned in this field categorizes the type of details needed for the KYC check. More information about the check is shown in the detailMessage and other applicable, corresponding fields. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/kyc:DetailsType'>eBay API documentation</a>
    string dataRequired?;
    # The timestamp in this field indicates the date by which the seller should resolve the KYC requirement. The timestamp in this field uses the UTC date and time format described in the ISO 8601 Standard. See below for this format and an example: MM-DD-YYYY HH:MM:SS 06-05-2020 10:34:18
    string dueDate?;
    # If applicable and available, a URL will be returned in this field, and the link will take the seller to an eBay page where they can provide the requested information.
    string remedyUrl?;
    # This field gives a short summary of what is required from the seller. An example might be, 'Upload bank document now.'. The detailMessage field will often provide more details on what is required of the seller.
    string alert?;
    # This field gives a detailed message about what is required from the seller. An example might be, 'Please upload a bank document by 2020-08-01 to get your account back in good standing.'.
    string detailMessage?;
};

# A complex type that indicates a parameter that caused an error and the value of the parameter which caused the error.
public type ErrorParameter record {
    # Name of the parameter that caused the error.
    string name?;
    # The value of the parameter that caused the error.
    string value?;
};

# Complex type that that gets populated with a response containing a payment policy.
public type SetPaymentPolicyResponse record {
    # The CategoryTypeEnum value to which this policy applies. This container is used to discern accounts that sell motor vehicles from those that do not. Restriction: Currently, each policy can be set to only one categoryTypes value at a time.
    CategoryType[] categoryTypes?;
    # A container that describes the details of a deposit. Used only with motor listings.
    Deposit deposit?;
    # An optional seller-defined description of the payment policy for internal use (this value is not displayed to end users).
    string description?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration fullPaymentDueIn?;
    # If set to true, payment is due upon receipt (eBay generates a receipt when the buyer agrees to purchase an item). The items will be available for other buyers until the payment is complete. This boolean must be set in the payment policy if the seller wants to create a listing that has an immediate payment requirement. Note: This container can be used for sellers who opt-in to the managed payments program, but some requirements do not apply.Default: False
    boolean immediatePay?;
    # The ID of the eBay marketplace to which this payment policy applies. If this value is not specified, the value defaults to the seller's eBay registration site. Note: A limited number of sellers, on a limited number of eBay marketplaces, are currently opted-in to the eBay managed payments program. To view the eBay marketplaces where managed payments are currently supported, see the managed payments landing page. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this payment policy. Names must be unique for policies assigned to the same marketplace. Note: eBay will create a new payment policy for sellers who opt-in to the managed payments program.Max length: 64
    string name?;
    # A free-form string field that allows sellers to add detailed payment instructions to their listings. The payment instructions appear on eBay's View Item and Checkout pages. eBay recommends sellers use this field to clarify payment policies for motor vehicle listings on eBay Motors. For example, sellers can include the specifics on the deposit (if required), pickup/delivery arrangements, and full payment details on the vehicle. The field allows only 500 characters as input, but due to the way the eBay web site UI treats characters, this field can return more than 500 characters in the response. For example, characters like &amp; and ' (ampersand and single quote) count as 5 characters each. Restriction: This container is not supported for sellers who opt-in to the managed payments program. Max length: 1000
    string paymentInstructions?;
    # If the seller is not opted-in to managed payments, this container returns a list of the payment methods accepted by the seller. When not opted-in to managed payments, each payment policy must specify at least one payment method. Note: The paymentMethods container is not returned if the seller is opted-in to the managed payments program.
    PaymentMethod[] paymentMethods?;
    # A unique eBay-assigned ID for a payment policy. This ID is generated when the policy is created.
    string paymentPolicyId?;
    # A list of warnings related to request. This field normally returns empty, which indicates the request did not generate any warnings.
    Error[] warnings?;
};

# Contains the payments program onboarding response
public type PaymentsProgramOnboardingResponse record {
    # This enumeration value indicates the eligibility of payment onboarding for the registered site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:PaymentsProgramOnboardingStatus'>eBay API documentation</a>
    string onboardingStatus?;
    # An array of the active process steps for payment onboarding and the status of each step. This array includes the step name, step status, and a webUrl to the IN_PROGRESS step. The step names are returned in sequential order.
    PaymentsProgramOnboardingSteps[] steps?;
};

# This type defines the fields for a seller's international return policy. If a seller does not populate the fields in this complex type, the international return policy defaults to the return policy set for domestic returns.
public type InternationalReturnOverrideType record {
    # Valid in the US marketplace only, this optional field indicates additional services (other than money-back) that sellers can offer buyers for remorse returns. As of version 1.2.0, the only accepted value for this field is REPLACEMENT. This field is valid in only the US marketplace, any supplied value is ignored in other marketplaces. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnMethodEnum'>eBay API documentation</a>
    string returnMethod?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration returnPeriod?;
    # If set to true, the seller allows international returns. If set to false, the seller does not accept international returns. Required if the seller wants to set an international return policy that differs from their domestic return policy.
    boolean returnsAccepted?;
    # This field indicates who is responsible for paying for the shipping charges for returned items. The field can be set to either BUYER or SELLER. Depending on the return policy and specifics of the return, either the buyer or the seller can be responsible for the return shipping costs. Note that the seller is always responsible for return shipping costs for SNAD-related issues. Required if the internationalOverride.returnsAccepted field is set to true. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ReturnShippingCostPayerEnum'>eBay API documentation</a>
    string returnShippingCostPayer?;
};

# This complex type defines a seller's shipping configuration for either a DOMESTIC or INTERNATIONAL shipping option. Shipping options configure the high-level settings for shipments, such as flat-rate or calculated shipping, and any rate tables the seller wants to associate with the policy. Each shippingOption element has a shippingServices container that defines the list of shipping carriers and services that are available for the parent shipping option (that is, for either DOMESTIC or INTERNATIONAL shipping). If a seller offers an international shipping option, they must also offer a domestic shipping option. Note that costType (FLAT_RATE or CALCULATED) is set in shippingOptions and that all associated shipping services must be able to support this cost type.
public type ShippingOption record {
    # Defines whether the shipping cost is FLAT_RATE (the same rate for all buyers), CALCULATED (the shipping rate varies by the ship-to location and size and weight of the package, as defined by the item), or NOT_SPECIFIED (for use with local pickup). Required if the policy offers shipping options using a shippingOptions container. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ShippingCostTypeEnum'>eBay API documentation</a>
    string costType?;
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount insuranceFee?;
    # This field has been deprecated. Shipping insurance is offered only via a shipping carrier's shipping services and is no longer available via eBay shipping policies.
    boolean insuranceOffered?;
    # Use this field to set the ShippingOption element to either DOMESTIC or INTERNATIONAL. Required if the policy offers shipping options using a shippingOptions container. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:ShippingOptionTypeEnum'>eBay API documentation</a>
    string optionType?;
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount packageHandlingCost?;
    # A unique eBay-assigned ID associated with a user-created shipping rate table. The locality of a shipping rate table can be either DOMESTIC or INTERNATIONAL and you must ensure the value specified in this field references a shipping rate table that matches the type specified in the shippingOptions.optionType field. If you mismatch the types, eBay responds with a 20403 error. Call getRateTable to retrieve information (including rateTableId values) on the rate tables configured by a seller. For information on creating rate tables, see Using shipping rate tables.
    string rateTableId?;
    # Contains a list of shipping services offered for either DOMESTIC or INTERNATIONAL shipments. Sellers can specify up to four domestic shipping services and up to five international shipping services by using separate shippingService containers for each. Note that if the seller is opted in to the Global Shipping Program, they can specify only four other international shipping services, regardless of whether or not Global Shipping is offered as one of the services. Required if the policy offers shipping options using a shippingOptions container.
    ShippingService[] shippingServices?;
};

# Defines the selling limit applied to an eBay seller's account.
public type SellingLimit record {
    # A complex type that describes the value of a monetary amount as represented by a global currency.
    Amount amount?;
    # The maximum quantity of items that can be listed by the seller per calendar month. Note that for a listing with variations, all of the items listed in the variation count as individual items.
    int quantity?;
};

# This root response container defines a seller's fulfillment policy for a specific marketplace and category type. fulfillmentPolicy encapsulates a seller's terms for fulfilling an order and includes the shipping carriers and services used for shipment and time the seller takes to ship an order. While each seller must define at least one fulfillment policy for every marketplace into which they sell, sellers can define multiple fulfillment policies for a single marketplace by specifying different configurations for the unique policies.
public type FulfillmentPolicy record {
    # The CategoryTypeEnum value to which this policy applies. Used to discern accounts that sell motor vehicles from those that don't. (Currently, each policy can be set to only one categoryTypes value at a time.)
    CategoryType[] categoryTypes?;
    # An optional seller-defined description of the fulfillment policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # If set to true, the seller offers freight shipping. Freight shipping can be used for large items over 150 lbs. Default: false
    boolean freightShipping?;
    # A unique eBay-assigned ID for the fulfillment policy. This ID is generated when the policy is created.
    string fulfillmentPolicyId?;
    # If set to true, the seller has opted-in to the eBay Global Shipping Program and that they use that service for their international shipments. Setting this value automatically sets the international shipping service for the policy to International Priority Shipping and the buyer does not need to set any other shipping services for their INTERNATIONAL shipping options (unless they sell items not covered by the Global Shipping Program). If this value is set to false, the seller is responsible for manually specifying the international shipping services, as described in Setting up worldwide shipping. To opt-in to the Global Shipping Program, log in to eBay and navigate to My Account &gt; Site Preferences &gt; Shipping preferences. Default: false
    boolean globalShipping?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration handlingTime?;
    # If set to true, no shipping is offered by this policy and the seller offers only local pickup of the item (normally from a non-business location). This option is most often used for customer-to-customer sales and if set, costType should be set to NOT_SPECIFIED. Default: false
    boolean localPickup?;
    # The ID of the eBay marketplace to which this fulfillment policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this fulfillment policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # If set to true, the seller offers the &quot;Click and Collect&quot; feature. Click and Collect is supported by the Inventory API, and it can be used with Add/Revise/Relist calls. To enable &quot;Click and Collect&quot;, a seller (1) must be eligible for Click and Collect and (2) must set this boolean field to 'true'. Currently, Click and Collect is available to only large retail merchants selling in the eBay AU and UK marketplaces. In addition to setting this field, the merchant must also do the following to enable the &quot;Click and Collect&quot; option on a listing: Have inventory for the product at one or more physical stores tied to the merchant's account. Sellers can use the createInventoryLocaion method in the Inventory API to associate physical stores to their account and they can then can add inventory to specific store locations. Set an immediate payment requirement on the item. The immediate payment feature requires the seller to: Set the immediatePay flag in the payment policy to 'true'. Include only one paymentMethods field in the payment policy and set its value to PAYPAL. Include a valid PayPal contact in the recipientAccountReference.referenceId field of the payment policy. Have a valid store location with a complete street address. When a UK merchant successfully lists an item with Click and Collect, prospective buyers within a reasonable distance from one of the merchant's stores (that has stock available) will see the &quot;Available for Click and Collect&quot; option on the listing, along with information on the closest store that has the item.Default: false
    boolean pickupDropOff?;
    # A list that defines the seller's shipping configurations for DOMESTIC and INTERNATIONAL order shipments. shippingOptions is a list with a single element if the seller ships to only domestic locations. If the seller also ships internationally, the list contains a second element that defines their international shipping options. Shipping options configure the high-level shipping settings that apply to orders, such as flat-rate or calculated shipping, any rate tables the seller wants to associate with the shipping services, plus other details (such as the shippingServices offered for domestic or international shipments).
    ShippingOption[] shippingOptions?;
    # This complex type contains the regionIncluded and regionExcluded fields, which indicate the areas to where the seller does and doesn't ship. Normally a seller ships to as many areas as possible using both DOMESTIC and INTERNATIONAL shipping options, and they don't have a need to exclude any regions from their ship-to locations. Here, there's no reason to set regionExcluded fields. However, it makes sense to set the regionExcluded field when a seller wants to exclude a small area that's within a larger area they service. For example, suppose a seller indicates they ship 'Worldwide', but for some reason must exclude a specific country, or world region. Note: Configuring the shipToLocations is tricky because the regionIncluded and regionExcluded fields are valid in different parts of the schema and their allowable settings vary upon the context. For details on setting these fields, see .
    RegionSet shipToLocations?;
};

# The response payload for return policy requests.
public type ReturnPolicyResponse record {
    # This field is for future use.
    string href?;
    # This field is for future use.
    int 'limit?;
    # This field is for future use.
    string next?;
    # This field is for future use.
    int offset?;
    # This field is for future use.
    string prev?;
    # The total number of items retrieved in the result set. If no items are found, this field is returned with a value of 0.
    int total?;
    # A list of the seller's return policies.
    ReturnPolicy[] returnPolicies?;
};

# This root container defines a seller's fulfillment policy for a specific marketplace and category type. Used when creating or updating a fulfillment policy, fulfillmentPolicyRequest encapsulates a seller's terms for fulfilling an order and includes the shipping carriers and services used for shipment and time the seller takes to ship an order. While each seller must define at least one fulfillment policy for every marketplace into which they sell, sellers can define multiple fulfillment policies for a single marketplace by specifying different configurations for the unique policies. A successful call returns a fulfillmentPolicyId, plus the Location response header contains the URI to the resource. Policy instructions can be localized by providing a locale in the Content-Language HTTP request header. For example: Content-Language: de-DE. Tip: For more on using business policies, see eBay business policies.
public type FulfillmentPolicyRequest record {
    # The CategoryTypeEnum value to which this policy applies. Used to discern accounts that sell motor vehicles from those that don't. (Currently, each policy can be set to only one categoryTypes value at a time.)
    CategoryType[] categoryTypes?;
    # An optional seller-defined description of the fulfillment policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # If set to true, the seller offers freight shipping. Freight shipping can be used for large items over 150 lbs. Default: false
    boolean freightShipping?;
    # If set to true, the seller has opted-in to the eBay Global Shipping Program and that they use that service for their international shipments. Setting this value automatically sets the international shipping service for the policy to International Priority Shipping and the buyer does not need to set any other shipping services for their INTERNATIONAL shipping options (unless they sell items not covered by the Global Shipping Program). If this value is set to false, the seller is responsible for manually specifying the international shipping services, as described in Setting up worldwide shipping. To opt-in to the Global Shipping Program, log in to eBay and navigate to My Account &gt; Site Preferences &gt; Shipping preferences. Default: false
    boolean globalShipping?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration handlingTime?;
    # If set to true, no shipping is offered by this policy and the seller offers only local pickup of the item (normally from a non-business location). This option is most often used for customer-to-customer sales and if set, costType should be set to NOT_SPECIFIED. Default: false
    boolean localPickup?;
    # The ID of the eBay marketplace to which this fulfillment policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this fulfillment policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # If set to true, the seller offers the &quot;Click and Collect&quot; feature. Click and Collect is supported by the Inventory API, and it can be used with Add/Revise/Relist calls. To enable &quot;Click and Collect&quot;, a seller (1) must be eligible for Click and Collect and (2) must set this boolean field to 'true'. Currently, Click and Collect is available to only large retail merchants selling in the eBay AU and UK marketplaces. In addition to setting this field, the merchant must also do the following to enable the &quot;Click and Collect&quot; option on a listing: Have inventory for the product at one or more physical stores tied to the merchant's account. Sellers can use the createInventoryLocaion method in the Inventory API to associate physical stores to their account and they can then can add inventory to specific store locations. Set an immediate payment requirement on the item. The immediate payment feature requires the seller to: Set the immediatePay flag in the payment policy to 'true'. Include only one paymentMethods field in the payment policy and set its value to PAYPAL. Include a valid PayPal contact in the recipientAccountReference.referenceId field of the payment policy. Have a valid store location with a complete street address. When a UK merchant successfully lists an item with Click and Collect, prospective buyers within a reasonable distance from one of the merchant's stores (that has stock available) will see the &quot;Available for Click and Collect&quot; option on the listing, along with information on the closest store that has the item.Default: false
    boolean pickupDropOff?;
    # A list that defines the seller's shipping configurations for DOMESTIC and INTERNATIONAL order shipments. shippingOptions is a list with a single element if the seller ships to only domestic locations. If the seller also ships internationally, the list contains a second element that defines their international shipping options. Shipping options configure the high-level shipping settings that apply to orders, such as flat-rate or calculated shipping, any rate tables the seller wants to associate with the shipping services, plus other details (such as the shippingServices offered for domestic or international shipments).
    ShippingOption[] shippingOptions?;
    # This complex type contains the regionIncluded and regionExcluded fields, which indicate the areas to where the seller does and doesn't ship. Normally a seller ships to as many areas as possible using both DOMESTIC and INTERNATIONAL shipping options, and they don't have a need to exclude any regions from their ship-to locations. Here, there's no reason to set regionExcluded fields. However, it makes sense to set the regionExcluded field when a seller wants to exclude a small area that's within a larger area they service. For example, suppose a seller indicates they ship 'Worldwide', but for some reason must exclude a specific country, or world region. Note: Configuring the shipToLocations is tricky because the regionIncluded and regionExcluded fields are valid in different parts of the schema and their allowable settings vary upon the context. For details on setting these fields, see .
    RegionSet shipToLocations?;
};

# Container specifying a payment method that is accepted by the seller. Specify multiple payment methods by repeating this container. For more on payment methods, see Accepted payments policy. Note that payment methods are not applicable to classified ad listings &ndash; all classified ad payments are handled off of the eBay platform.
public type PaymentMethod record {
    # It's important to note that the credit card brands Visa and MasterCard must both be listed if either one is listed, as is shown in the following code fragment: &quot;paymentMethods&quot;: [{ &quot;brands&quot;: [VISA, MASTERCARD] }] ... Note: Different eBay marketplaces may or may not support this field. Use the Trading API GetCategoryFeatures call with FeatureID set to PaymentMethods and DetailLevel set to ReturnAll to see what credit card brands different marketplaces support. If the GetCategoryFeatures call returns details on credit card brands for the categories in which you sell, then you can use this field to list the credit card brands the seller accepts. If, on the other hand, GetCategoryFeatures does not enumerate credit card brands for your target site (for example, if it returns PaymentMethod set to CCAccepted), then you cannot enumerate specific credit card brands with this field for that marketplace. Required if paymentMethodType is set to CREDIT_CARD. A list of credit card brands accepted by the seller.
    string[] brands?;
    # The payment method, selected from the supported payment method types. Use GetCategoryFeatures in the Trading API to retrieve the payment methods allowed for a category on a specific marketplace, as well as the default payment method for that marketplace (review the SiteDefaults.PaymentMethod field). For example, the response from GetCategoryFeatures shows that on the US marketplace, most categories allow only electronic payments via credit cards, PayPal, and the like. Also, note that GeteBayDetails does not return payment method information. Note: If you create item listings using the Inventory API, you must set this field to PAYPAL (currently, the Inventory API supports only fixed-prince GTC items where the only supported paymentMethod is PayPal). For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:PaymentMethodTypeEnum'>eBay API documentation</a>
    string paymentMethodType?;
    # Recipient account information, like PayPal email. If the payment method is PayPal, this structure contains the recipient's PayPal email address.
    RecipientAccountReference recipientAccountReference?;
};

# This type defines information for a region.
public type Region record {
    # A string that indicates the name of a region, as defined by eBay. A &quot;region&quot; can be either a 'world region' (e.g., the &quot;Middle East&quot; or &quot;Southeast Asia&quot;) or a country, as represented with a two-letter country code. Use GeteBayDetails to get the values accepted by this field. The values that you're allowed to use for a specific regionName field depend on the context in which you are setting the value. For details on how to set the values for this field, see The shipToLocations container.
    string regionName?;
    # Reserved for future use. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:RegionTypeEnum'>eBay API documentation</a>
    string regionType?;
};

# Recipient account information, like PayPal email. If the payment method is PayPal, this structure contains the recipient's PayPal email address.
public type RecipientAccountReference record {
    # Contains the PayPal email address of the recipient (buyer) if referenceType is set to PAYPAL_EMAIL.
    string referenceId?;
    # A reference a recipient's account. Currently only PAYPAL_EMAIL is valid. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/api:RecipientAccountReferenceTypeEnum'>eBay API documentation</a>
    string referenceType?;
};

# Root container that defines the fields for a seller's payment policy. The paymentPolicy encapsulates a seller's payment terms and consists of payment details for the seller, the name and description of the policy, and the marketplace and category group(s) covered by the payment policy. While each seller must define at least one payment policy for every marketplace into which they sell, sellers can define multiple payment policies for a single marketplace by specifying different configurations for the unique policies.
public type PaymentPolicy record {
    # The CategoryTypeEnum value to which this policy applies. Used to discern accounts that sell motor vehicles from those that don't. (Currently, each policy can be set to only one categoryTypes value at a time.)
    CategoryType[] categoryTypes?;
    # A container that describes the details of a deposit. Used only with motor listings.
    Deposit deposit?;
    # An optional seller-defined description of the payment policy for internal use (this value is not displayed to end users). Max length: 250
    string description?;
    # A complex type that specifies a period of time using a specified time-measurement unit.
    TimeDuration fullPaymentDueIn?;
    # If set to true, payment is due upon receipt (eBay generates a receipt when the buyer agrees to purchase an item). This boolean must be set in the payment policy if the seller wants to create a listing that has an &quot;immediate payment&quot; requirement. The seller can change the immediate payment requirement at any time during the life cycle of a listing. The following must be true before a seller can apply an immediate payment requirement to an item: The seller must have a PayPal Business account. The Buy It Now price cannot be higher than $60,000 USD. The eBay marketplace on which the item is listed must support PayPal payments. The listing type must be fixed-price, or an auction with a Buy It Now option.To enable the immediate payment requirement, the seller must also perform the following actions via API calls: Provide a valid paymentMethods.recipientAccountReference.referenceId value. Offer PayPal as the only payment method for the item(s). Specify all related costs to the buyer (because the buyer is not be able to use the Buyer Request Total feature in an immediate payment listing); these costs include flat-rate shipping costs for each domestic and international shipping service offered, package handling costs, and any shipping surcharges. Include and set the shippingProfileDiscountInfo container values if you are going to use promotional shipping discounts.For more information, see the Understanding immediate payment Help page. Note: Listings created with the Inventory API must reference a payment policy that has immediatePay is set to true. Items listed with the Inventory API must also be fixed-price good-till-canceled (GTC) listings where PayPal is the only supported payment method (paymentMethod must be set to PAYPAL). Default: false
    boolean immediatePay?;
    # The ID of the eBay marketplace to which the payment policy applies. If this value is not specified, value defaults to the seller's eBay registration site. For implementation help, refer to <a href='https://developer.ebay.com/api-docs/sell/account/types/ba:MarketplaceIdEnum'>eBay API documentation</a>
    string marketplaceId?;
    # A user-defined name for this payment policy. Names must be unique for policies assigned to the same marketplace. Max length: 64
    string name?;
    # This free-form string field gives sellers the ability add detailed payment instructions to their listings. The payment instructions appear on eBay's View Item and Checkout pages. eBay recommends sellers use this field to clarify payment policies for motor vehicle listings on eBay Motors. For example, sellers can include the specifics on the deposit (if required), pickup/delivery arrangements, and full payment details on the vehicle. The field allows only 500 characters as input, but due to the way the eBay web site UI treats characters, this field can return more than 500 characters in the response. For example, characters like &amp; and ' (ampersand and single quote) count as 5 characters each. Max length: 1000.
    string paymentInstructions?;
    # If the seller is not opted-in to managed payments, this container returns a list of the payment methods accepted by the seller. When not opted-in to managed payments, each payment policy must specify at least one payment method. Note: The paymentMethods container is not returned if the seller is opted-in to the managed payments program.
    PaymentMethod[] paymentMethods?;
    # A unique eBay-assigned ID for a payment policy. This ID is generated when the policy is created.
    string paymentPolicyId?;
};

# A container that describes the how the sales tax rate is calculated.
public type SalesTaxBase record {
    # The sales tax rate, as a percentage of the sale.
    string salesTaxPercentage?;
    # If set to true, shipping and handling charges are taxed.
    boolean shippingAndHandlingTaxed?;
};

# A merchant's selling limit, and the status of their account registration.
public type SellingPrivileges record {
    # If set to true, the seller's registration is completed.
    boolean sellerRegistrationCompleted?;
    # Defines the selling limit applied to an eBay seller's account.
    SellingLimit sellingLimit?;
};
