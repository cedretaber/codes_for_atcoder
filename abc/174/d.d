import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = readln.chomp.to!(char[]);

    int c;
    int i, j = N-1;
    while (i < j) {
        while (i < N && cs[i] != 'W') ++i;
        while (j >= 0 && cs[j] != 'R') --j;
        if (i < j && j < N) {
            ++c;
            ++i;
            --j;
        }
    }
    writeln(c);
}

/*

WWWRRWWWWWRWR


WWWRRWWWWWRWR
RWWRRWWWWWRWW
RRWRRWWWWWWWW
RRRRWWWWWWWWW

*/