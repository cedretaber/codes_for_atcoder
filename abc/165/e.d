import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int[] as, bs;
    int t = 1, cnt;
    foreach_reverse (i; 1..M+1) if (i%2 == 1) {
        as ~= t++;
        ++cnt;
    }
    t += cnt-1;
    foreach (i; 1..M+1) if (i%2 == 1) {
        bs ~= t--;
    }
    t += cnt+1;
    cnt = 0;
    foreach_reverse (i; 1..M+1) if (i%2 == 0) {
        as ~= t++;
        ++cnt;
    }
    t += cnt;
    foreach (i; 1..M+1) if (i%2 == 0) {
        bs ~= t--;
    }
    foreach (i, a; as) {
        auto b = bs[i];
        writeln(a, " ", b);
    }
}

/*

1 2 3 4
2 3 4 1
3 4 1 2
4 1 2 3

1 aa
2 b b
3 c  c
4 d   d
5 e    e

ecaace
db bd

1 2 3 4 5 6 7
2 3 4 5 6 7 1
3 4 5 6 7 1 2
4 5 6 7 1 2 3
5 6 7 1 2 3 4
6 7 1 2 3 4 5
7 1 2 3 4 5 6

caacb b
1234567

1-4
2-3
5-7

1  2  3  4  5  6  7  8  9  10 11 12
2  3  4  5  6  7  8  9  10 11 12 1 
3  4  5  6  7  8  9  10 11 12 1  2  
4  5  6  7  8  9  10 11 12 1  2  3 
5  6  7  8  9  10 11 12 1  2  3  4 
6  7  8  9  10 11 12 1  2  3  4  5
7  8  9  10 11 12 1  2  3  4  5  6 
8  9  10 11 12 1  2  3  4  5  6  7 
9  10 11 12 1  2  3  4  5  6  7  8 
10 11 12 1  2  3  4  5  6  7  8  9 
11 12 1  2  3  4  5  6  7  8  9  10 
12 1  2  3  4  5  6  7  8  9  10 11





1234567891011
ecaacedb bd

1-6
2-5
3-4
7-11
8-10

*/