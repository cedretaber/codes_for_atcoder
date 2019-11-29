import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = new int[](N);
    foreach (i; 0..N) hs[i] = readln.chomp.to!int;

    char ud = '-';
    int s;
    int last, res;
    foreach (i, h; hs) {
        switch (ud) {
            case 'u':
                if (h < last) {
                    ud = 'd';
                }
                break;
            case 'd':
                if (h > last) {
                    res = max(res, i.to!int - s);
                    s = i.to!int - 1;
                    ud = 'u';
                }
                break;
            default:
                s = 0;
                ud = hs[1] > hs[0] ? 'u' : 'd';
        }
        last = h;
    }
    res = max(res, N - s);
    writeln(res);
}