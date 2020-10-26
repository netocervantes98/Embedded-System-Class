#include <stdio.h>
#include <stdint.h>

int main(void)
{
    uint32_t qe2_var[3] = {10, 20, 30};
    uint32_t *qe2_ptr = (uint32_t *)&qe2_var[1];
    qe2_ptr--;
    printf("before...ptr is: %p and qe2_var is: %u\n", (qe2_ptr), *(qe2_ptr));
    qe2_ptr++;
    qe2_ptr++;
    printf("after....ptr is: %p and qe2_var is: %u\n\n", qe2_ptr, *qe2_ptr);
    return 0;
}