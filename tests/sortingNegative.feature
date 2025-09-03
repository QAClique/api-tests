#---------------------------------------------------------------------------------------------------
Feature: Globe And Mail - Mutual fund leaders Tests
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
Background:
#---------------------------------------------------------------------------------------------------

  * url `${baseUrl}`

#---------------------------------------------------------------------------------------------------
Scenario Outline: Missing field <field> in request
#---------------------------------------------------------------------------------------------------

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
