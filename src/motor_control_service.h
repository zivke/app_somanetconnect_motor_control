#pragma once

interface motor_control_service_interface {
    void start();
    void stop();
    void set_velocity(int velocity);
    void set_torque(int torque);
    void set_position(int position);
};

void motor_control_service(unsigned int instance, server interface motor_control_service_interface mcsi);
