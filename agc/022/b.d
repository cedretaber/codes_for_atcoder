import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    if (N == 3) {
        writeln("2 5 63");
    } else if (N == 4) {
        writeln("2 5 20 63");
    } else if (N == 5) {
        writeln("2 3 5 8 12");
    } else {
        int[] r;
        r.length = N;
        int i, n = 2, m;
        while (i < N) {
            r[i++] = n;
            m = (m + n) % 6;
            do {
                ++n;
            }
            while (n%2 != 0 && n%3 != 0);
        }
        switch (m) {
            case 2:
                i = 4;
                while (n%6 != 0) ++n;
                break;
            case 3:
                i = 5;
                while (n%6 != 0) ++n;
                break;
            case 5:
                i = 5;
                while (n%6 != 4) ++n;
                break;
            default:
                i = 0;
                n = r[i];
        }
        r[i] = n;
        writeln(r.to!(string[]).join(" "));
    }
}