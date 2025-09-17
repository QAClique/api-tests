#---------------------------------------------------------------------------------------------------
Feature: Globe And Mail - Mutual fund leaders Negative Tests
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
Background:
#---------------------------------------------------------------------------------------------------

  * url `${baseUrl}`

  * def payload =
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange,managedAssets.format(millions),tradeTime,quickLink",
      "lists":  "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "orderBy":  "lastPrice",
      "orderDir": "asc"
    }
    """

#---------------------------------------------------------------------------------------------------
Scenario Outline: Missing field <field> in request
#---------------------------------------------------------------------------------------------------

  * remove payload.<field>

  Given request payload
  When method POST
  Then status 500
  And match response.error == "Server error"

Examples:
  | field    |
  | fields   |
  | lists    |
  | orderDir |

#---------------------------------------------------------------------------------------------------
Scenario: Wrong type for field "orderDir" in request
#---------------------------------------------------------------------------------------------------

  * payload.orderDir = 12345

  Given request payload
  When method POST
  Then status 500
  And match response.error == "Server error"

#---------------------------------------------------------------------------------------------------
Scenario Outline: Invalid HTTP method <method>
#---------------------------------------------------------------------------------------------------

  Given request payload
  When method <method>
  Then status 404
  And match response contains "<pre>Cannot <method> /api/funds</pre>"

Examples:
  | method   |
  | DELETE   |
  | GET      |
  | PATCH    |
  | PUT      |
  | TRACE    |
