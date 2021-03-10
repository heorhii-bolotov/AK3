arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -g3 -mcpu=cortex-m4 -mthumb -Wall start.S -o start.o
arm-none-eabi-gcc start.o -mcpu=cortex-m4 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T ./lscript.ld -o firmware.elf
arm-none-eabi-objcopy -O binary -F elf32-littlearm firmware.elf firmware.bin

PATH=$PATH:~/opt/xPacks/qemu-arm/xpack-qemu-arm-2.8.0-12/bin/

qemu-system-gnuarmeclipse --verbose --verbose --board STM32F4-Discovery -mcu STM32F407VG -d unimp,guest_errors --image firmware.bin --semihosting-config enable=on,target=native -s -S

gdb-multiarch firmware.elf

target extended-remote:1234

step 

step 

# then automatize

make 

make qemu 
