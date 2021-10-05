# Functional Requirements

- The program should be able to receive the file content (_JSON object per line_) through _stdin_ named __operations__.
- For each processed operation return an output according to the business rules through _stdout_.
- The program should not rely on any external database, and the application's internal state should be handled byan explicit in-memory structure. The application state needs to be reset at the start of the application.
- The program should be able to handle two types of transactions: __Account creation__ and __Transaction authorization__.

## Rules Violations

- Violations are not considered errors as they are expected to happen 
- The program execution should continue normally after any kind of violation.
- If no violations happen during operation processing, the field violations should return an empty vector __[]__.
- Authorizer operations that had violations should not be saved in the application's internal state.
- Given a transaction that violates more than one logic, the authorizer must return all violations that occurred.

| VIOLATION                         | DESCRIPTION                                                                                               |
|:----------------------------------|:----------------------------------------------------------------------------------------------------------|
| __account-not-initialized__       | No transaction should be accepted without a properly initialized account                                  |
| __card-not-active__               | No transaction should be accepted when the card is not active                                             |
| __insufficient-limit__            | The transaction amount should not exceed the available limit                                              |
| __high-frequency-small-interval__ | There should be no more than 3 transactions within a 2 minutes interval                                   |
| __doubled-transaction__           | There should be no more than 1 similar transaction (same amount and merchant) within a 2 minutes interval |

## Behavior Assumptions

1. All monetary values are positive integers using a currency without cents.
2. The transactions will arrive at the Authorizer in chronological order.
3. The Authorizer will deal with just one account.
4. Input parsing errors will not happen.


#### I/O.

Input JSON format for account creation and authorization transactions.

```json
{
    "account": {
        "active-card": true, 
        "available-limit": 100
    }
}
```

```json
{
    "transaction": {
        "merchant": "Burger King", 
        "amount": 20, 
        "time": "2019-02-13T11:00:00.000Z"
    }
}
```

### Data Entitis

#### Account

Singleton inmutable object.

| ATTRIBUTE           | DATA TYPE |
|:--------------------|:----------|
| __available-limit__ | _Integer_ |
| __active-card__     | _Boolean_ |

#### Authorization

Volatile object.

| ATTRIBUTE    | DATA TYPE  |
|:-------------|:-----------|
| __merchant__ | _String_   |
| __amount__   | _Integer_  |
| __time__     | _Datetime_ |
