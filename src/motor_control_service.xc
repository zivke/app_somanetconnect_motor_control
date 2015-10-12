#include "motor_control_service.h"
#include <somanet_connect_xscope.h>
#include <stdint.h>
#include <stdio.h>
#include <xs1.h>

void motor_control_service(unsigned int instance, server interface motor_control_service_interface mcsi) {
    timer t;
    uint64_t time;
    const uint64_t period = 250000; // 250000 timer ticks = 1ms (ReferenceFrequency="250MHz")

    int run = 0;

    int velocity = 100;
    int torque = 50;
    int position = 150;

    t :> time;
    while(1) {
        select {
            case mcsi.start(): {
                run = 1;
                printf("Motor started\n");
                break;
            }

            case mcsi.stop(): {
                run = 0;
                printf("Motor stopped\n");
                break;
            }

            case mcsi.set_velocity(int velocity_value): {
                velocity = velocity_value;
                break;
            }

            case mcsi.set_torque(int torque_value): {
                torque = torque_value;
                break;
            }

            case mcsi.set_position(int position_value): {
                position = position_value;
                break;
            }

            case t when timerafter(time) :> void: {
                if (run) {
#ifdef SOMANET_CONNECT
                    somanet_connect_xscope_int(MOTCTRL, MOTCTRL_ACTUAL_VELOCITY, instance, velocity);
                    somanet_connect_xscope_int(MOTCTRL, MOTCTRL_ACTUAL_TORQUE, instance, torque);
                    somanet_connect_xscope_int(MOTCTRL, MOTCTRL_ACTUAL_POSITION, instance, position);
#endif
                }
                time += period;

                break;
            }
        }
    }
}
