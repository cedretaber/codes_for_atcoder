import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    sort!"a > b"(as);
    N -= 2;
    long r = as[0];
    size_t i = 1;
    while (N > 0) {
        r += as[i];
        --N;
        if (N == 0) break;
        r += as[i];
        --N;
        ++i;
    }
    writeln(r);
}

/*

7 6 5 4 3 2 1

7
7 6 -> +7
5 6 7  -> +6
5 6 4 7 -> +6
5 3 6 4 7 -> +5
2 5 3 6 4 7 -> +5
2 5 3 6 1 4 7 -> +4

3 2 2 1

3
3 2 -> +3
2 3 2 -> +2
2 1 3 2 -> +2

1 2 3 4 5 6

6
6 5 -> +6
4 6 5 -> +5
4 6 3 5 -> +5
2 4 6 3 5 -> +4
2 4 1 6 3 5 -> +4

*/