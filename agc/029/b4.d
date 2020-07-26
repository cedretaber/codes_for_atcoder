import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum BS = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648];

void main()
{
    auto N = readln.chomp.to!int;
    long[] AS;
    int[long] CS;
    foreach (a; readln.split.to!(long[])) {
        AS ~= a;
        ++CS[a];
    }
    sort(AS);
    AS = AS.uniq.array;
    int r;
    foreach_reverse (a; AS) {
        while (CS[a] > 0) {
            foreach_reverse (b; BS) if (b-a in CS && CS[b-a] > 0) {
                if (a == b-a && CS[a] == 1) {
                    CS[a] = 0;
                    break;
                }
                ++r;
                --CS[a];
                --CS[b-a];
                goto next;
            }
            break;
            next:
        }
    }
    writeln(r);
}