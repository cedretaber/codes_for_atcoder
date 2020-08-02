import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto K = readln.chomp.to!long;
    auto k = K;
    int r;
    while (k) {
        ++r;
        foreach (long i; 0..10) {
            if ((k+K*i)%10 == 7) {
                k = (k+K*i)/10;
                goto ok;
            }
        }
        writeln(-1);
        return;
        ok:
    }
    writeln(r);
}

/*

7777

707
 707


101
707

70


999983

899984

1899967

189996

*/