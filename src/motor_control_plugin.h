#pragma once

#include <somanet_connect_plugin_interface.h>
#include "motor_control_service.h"

#define MOTOR_CONTROL_PLUGIN_TYPE 'm'
#define MOTOR_CONTROL_PLUGIN_START 's'
#define MOTOR_CONTROL_PLUGIN_STOP 't'
#define MOTOR_CONTROL_PLUGIN_SET_VELOCITY 'v'
#define MOTOR_CONTROL_PLUGIN_SET_TORQUE 'q'
#define MOTOR_CONTROL_PLUGIN_SET_POSITION 'p'

[[combinable]]
void motor_control_plugin(server interface somanet_connect_plugin_interface scpi, client interface motor_control_service_interface mcsi[length], unsigned length);
