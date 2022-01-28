variable "name" {
  description = "The specification of module name."
  type        = string
  default     = "terraform"
}

variable "instance_type" {
  description = "The specification of the instance type. Valid values: professional, vip."
  type        = string
  default     = "professional"
}

variable "max_tps" {
  description = "The specification of the peak TPS traffic. The smallest valid value is 1000 and the largest value is 100,000."
  type        = number
  default     = 1000
}

variable "queue_capacity" {
  description = "The specification of the queue capacity. The smallest value is 50 and the step size 5."
  type        = number
  default     = 50
}

variable "support_eip" {
  description = "The specification of support EIP."
  type        = bool
  default     = true
}

variable "max_eip_tps" {
  description = "The specification of the max eip tps. It is valid when support_eip is true. The valid value is [128, 45000] with the step size 128"
  type        = number
  default     = 128
}

variable "payment_type" {
  description = "The specification of the payment type."
  type        = string
  default     = "Subscription"
}

variable "period" {
  description = "The specification of the period. Valid values: 1, 12, 2, 24, 3, 6."
  type        = number
  default     = 1
}

variable "create" {
  description = "Whether to create instance. If false, you can specify an existing instance by setting 'instance_id'."
  type        = bool
  default     = true
}

variable "instance_id" {
  description = "The instance_id used to RabbitMQ. If set, the 'create' will be ignored."
  type        = string
  default     = ""
}

variable "auto_delete_state" {
  description = "Specifies whether the Auto Delete attribute is configured. Valid values: true: The Auto Delete attributeis configured. If the last queue that is bound to an exchange is unbound, the exchange is automatically deleted. false: The Auto Delete attribute is not configured. If the last queue that is bound to an exchange is unbound, the exchange is not automatically deleted."
  type        = bool
  default     = false
}

variable "exchange_type" {
  description = "The specification of the exchange type. Valid values: FANOUT, DIRECT, TOPIC, HEADERS"
type = string
default = "HEADERS"
}

variable "internal" {
description = "The specification of the internal."
type = bool
default = false
}

variable "argument" {
description = "The specification of the argument."
type = string
default = "x-match:all"
}

variable "binding_type" {
description = "The specification of the binding type. Valid values: EXCHANGE, QUEUE."
type = string
default = "QUEUE"
}
