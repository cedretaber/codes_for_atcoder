import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!long;

    if (N <= 26*2) {
        writeln(3 * (N/2) + N%2);
        return;
    }

    long r;
    foreach (long i; 1..10) {
        auto c = 26L^^i;
        if (N > c) {
            r += c * i;
            N -= c;
        } else {
            r += N * i;
            break;
        }
    }
    writeln(r);
}

/*

a ab b bc c cd d de ... y yz z za 26*2
ab ba ac ca ad da ae ea ... 

*/