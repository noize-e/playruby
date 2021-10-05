# CHANGELOG

## September 10, 2021

**Commit**: `[master 122cfdd]`

### _[Removed]_ data.manager.Tasker

This module has been deprecated and removed. All its major functionality has been moved into a domain context agnostic extension __`TasksPipeline`__ which now lives in the `misc.ext` namespace.


### misc.ext.TasksPipeline

Besides inheriting the complete functionality data.manager.Tasker, some modifications were implemented:
        
- Method 'setup_tasker' removed.
- Instance variable `@stages_data` changed to `@tasks_data`.
- Memoization of instance variable `@tasks_data`.
- Memoization of instance variable `@tasks`.
- Method `execute_first_stage` name changed to `execute_first_task`
- Method `execute_stage` name changed to `execute_task` and moved into a private context
- Method `get_stages_data` name changed to `get_tasks_data`.
- Method `next_stage` name changed to `next_task`.
- Methods `execute_task` and `set_completion_status`. 
  moved into a private context
- Method `stage_data_body` name changed `task_data_body`.

### lib.authorizer.data.entity.Transaction

- Removed unnecessary `@data` value assigment in proc.
- Changed `get_event_listener` proc object value `call` payload; now `get_tasks_data` instead of `data` accesor.

---

## September 11, 2021

**Commit**: `[master eb75435]`

### data.entity.Account

- Memoization of instance variable `@card`.

### data.entity.Card

- Method `withdrawal` defined.
- Private method `update_balance` defined.
- Private method `raise_violation` defined.

### data.entity.rules.AuthorizationViolations

- Added `INSUFFICIENT_LIMIT` constant.

### service.layer.rb

- Added card withdrawal to authorization transaction.

---

**Commit**: `[master 2759572]`

### data.entity.Account

- Added splat operator in `create` method, expect to receive 2 arguments
- Method `withdrawal` total of arguments changed, now receives `merchant`, `amount`, `timestamp`

### data.manager.Transaction

- Added operation MD5 digest checksum generator in `build` method.
- Added operation checksum validation for double transactions.

### domain.Router

- Added support for double transactions management.

### domain.router.Processor

- Added new method `end_stage`.

### domain.transaction.Processor

- Added new method `skip_transaction?`.
- Added new method `skipped_transaction`.
- Argument `transaction_ops` name changed to operations whithin all realted instance variables and methods.

### misc.ext.Observable

- Removed unnecessary `setup_*` methods.