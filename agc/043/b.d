import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    int[] as;
    int[3] ns;
    foreach (c; readln.chomp) {
        auto a = c - '1';
        ++ns[a];
        as ~= a;
    }

    foreach (ref a; as) {
        if (ns[1] == 0) {
            a /= 2;
        } else if (a == 2) {
            a = 0;
        }
    }

    // Lucas' theorem
    auto ls = new bool[](N);
    loop: foreach (x; 0..N) {
        static foreach (i; 0..20) if (((N-1)&(1<<i)) < (x&(1<<i))) continue loop;
        ls[x] = true;
    }

    int x;
    foreach (i, a; as) if (ls[i]) x ^= a;
    writeln(x == 1 ? ns[1] > 0 ? 1 : 2 : 0);
}

/*

4
1231

1
01
112
0120

a b c d
(a^b) (b^c) (c^d)
(a^b)^(b^c) (b^c)^(c^d)



1
0 1
1 1 2
0 1 2 0
-
1 3 3 1


0
1 1
0 1 0
-
1 2 1


10
2311312312

0
11
010
0011
11101
121001
1021110
12201011
120221121
1200201201

*/