import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto ab = readln.split.to!(long[]);
        auto A = ab[0];
        auto B = ab[1];
        if (A > B) swap(A, B);

        if (A == B || A+1 == B) {
            writeln(2*(A-1));
            continue;
        }

        auto c = sqrt((A*B).to!double).to!long;
        if (c^^2 == A*B) --c;
        if (c * (c+1) >= A*B) {
            writeln(2*(c-1));
        } else {
            writeln(2*c-1);
        }
    }
}

/*

3 3
= 9

1 5
2 4
4 2
5 1


5 6
= 30

1 9
2 8
3 7
4 6
6 4
7 3
8 2
9 1

*/