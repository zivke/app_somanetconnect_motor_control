#include "motor_control_plugin.h"
#include <somanet_connect_plugin_interface.h>

#include <print.h>

[[combinable]]
void motor_control_plugin(server interface somanet_connect_plugin_interface scpi, client interface motor_control_service_interface mcsi[length], unsigned length) {
    unsigned char type = MOTOR_CONTROL_PLUGIN_TYPE;

    while(1) {
        select {
            case scpi.get_type() -> unsigned char type_value: {
                type_value = type;
                break;
            }

            case scpi.get_total_services() -> unsigned int value: {
                value = length;
                break;
            }

            case scpi.get_command(unsigned char command[n], unsigned n): {
                unsigned int i = command[0];
                switch (command[1]) {
                    case MOTOR_CONTROL_PLUGIN_START: {
                        mcsi[i].start();
                        break;
                    }

                    case MOTOR_CONTROL_PLUGIN_STOP: {
                        mcsi[i].stop();
                        break;
                    }

                    case MOTOR_CONTROL_PLUGIN_SET_VELOCITY: {
                        int value = command[5] | (command[4] << 8) | (command[3] << 16) | (command[2] << 24);
                        mcsi[i].set_velocity(value);
                        break;
                    }

                    default: {
                        printstrln("Unknown command!");
                        break;
                    }
                }
                break;
            }
        }
    }
}

