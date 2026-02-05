#---------------------------------------------------------------------------------------------------
Feature: Number of Funds and Fields Tests
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
Background:
#---------------------------------------------------------------------------------------------------

  * url baseUrl
  * def fundSchema = read(`file:${root}/schema/fund.json`)
  * def fundListSchema = read(`file:${root}/schema/fundlist.json`)

#---------------------------------------------------------------------------------------------------
Scenario: Verify number of funds returned
#---------------------------------------------------------------------------------------------------

  * def randomFundNumber = Math.floor(Math.random() * 10) + 1

  # The schema assumes the default set of fields, since we are modifying the list, we can't do schema validation here
  Given request
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "limit": #(randomFundNumber)
    }
    """
  When method POST
  Then status 200
  And match header Content-Type == "application/json; charset=utf-8"
  And match response.count == randomFundNumber
  And assert response.data.length == randomFundNumber

#---------------------------------------------------------------------------------------------------
Scenario Outline: Verify field <field> is returned
#---------------------------------------------------------------------------------------------------

  # The schema assumes the default set of fields, since we are modifying the list, we can't do schema validation here
  Given request
    """
    {
      "fields": "<field>",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "limit": 3
    }
    """
  When method POST
  Then status 200
  And match header Content-Type == "application/json; charset=utf-8"
  And match each response.data[*].<field> == "#present"

Examples:
  | field         |
  | symbol        |
  | symbolName    |
  | lastPrice     |
  | priceChange   |
  | percentChange |
  | managedAssets |
  | tradeTime     |
  | quickLink     |

#---------------------------------------------------------------------------------------------------
Scenario: Verify all fields are returned
#---------------------------------------------------------------------------------------------------

  Given request
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange,managedAssets.format(millions),tradeTime,quickLink",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "limit": 10
    }
    """
  When method POST
  Then status 200
  And match header Content-Type == "application/json; charset=utf-8"
  And match response == fundListSchema
  And match response.total == 200

#---------------------------------------------------------------------------------------------------
Scenario: Default limit
#---------------------------------------------------------------------------------------------------

  Given request
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange,managedAssets.format(millions),tradeTime,quickLink",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      }
    }
    """
  When method POST
  Then status 200
  And match header Content-Type == "application/json; charset=utf-8"
  And match response == fundListSchema
  And match response.count == 200
  And assert response.data.length == 200
