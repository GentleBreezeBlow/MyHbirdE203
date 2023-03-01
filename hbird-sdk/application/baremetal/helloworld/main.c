#define WRITE_REG_32(ADDRESS,data)  ((*((volatile unsigned long  *)(ADDRESS))) = (data))

#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include "hbird_sdk_soc.h"
    
void sim_pass(void)
{
    WRITE_REG_32(0x10041000,6);
}

int main(void)
{

    srand(__get_rv_cycle()  | __get_rv_instret() | __RV_CSR_READ(CSR_MCYCLE));
    uint32_t rval = rand();
    rv_csr_t misa = __RV_CSR_READ(CSR_MISA);

    printf("MISA: 0x%lx\r\n", misa);
   

    for (int i = 0; i < 20; i ++) {
        printf("%d: Hello World From RISC-V Processor!\r\n", i);
    }
    sim_pass();
}
