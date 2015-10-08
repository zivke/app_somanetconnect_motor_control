#include <CORE_C22-rev-a.inc>

#include <somanet_connect_server.h>
#include "motor_control_plugin.h"
#include <xscope.h>

#define NO_OF_PLUGINS 1
#define NO_OF_MOTOR_CONTROL_SERVICES 3

int main(void) {
    chan c_host_data;
    interface somanet_connect_plugin_interface scpi[NO_OF_PLUGINS];
    interface motor_control_service_interface mcsi[NO_OF_MOTOR_CONTROL_SERVICES];

    par
    {
        xscope_host_data(c_host_data);

        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(c_host_data, scpi, NO_OF_PLUGINS);
                motor_control_plugin(scpi[0], mcsi, NO_OF_MOTOR_CONTROL_SERVICES);
            }
        }

        on tile[IFM_TILE]:
        {
            par {
                motor_control_service(0, mcsi[0]);
                motor_control_service(1, mcsi[1]);
                motor_control_service(2, mcsi[2]);
            }
        }
    }

    return 0;
}
