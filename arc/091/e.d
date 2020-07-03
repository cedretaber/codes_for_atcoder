import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    if (A == 1 && B == N) {
        writeln(1.iota(N+1).array.reverse.to!(string[]).join(" "));
        return;
    } else if (A == N && B == 1) {
        writeln(1.iota(N+1).array.to!(string[]).join(" "));
        return;
    }

    bool rev;
    if (N-A >= B-1 && (N+A-1)/A <= B) {
        rev = false;
    } else if (N-B >= A-1 && (N+B-1)/B <= A) {
        rev = true;
        swap(A, B);
    } else {
        writeln(-1);
        return;
    }
    auto r = N-A;
    int x;
    while (r-A + x+1 > B-1) {
        r -= A;
        x += 1;
    }
    int d;
    if (r+x > B-1) {
        d = r + x+1 - (B-1);
        r -= d;
    }
    int[] res;
    int i = N;
    if (r) {
        res ~= (N-r+1).iota(N+1).array.reverse;
        i -= r;
    }
    if (d) {
        foreach_reverse (j; 0..d) res ~= i-j;
        i -= d;
    }
    foreach (_x; 0..x+1) {
        foreach_reverse (j; 0..A) res ~= i-j;
        i -= A;
    }
    if (rev) res = res.reverse.array;
    writeln(res.to!(string[]).join(" "));
}

/*

r + x+1 = B-1 + d

10 2 7
10 9 8 7 5 6 3 4 1 2

9 3 3
7 8 9 4 5 6 1 2 3

9 3 7
9 8 7 6 5 4 1 2 3

9 2 5
9 7 8 5 6 3 4 1 2

9 3 4
9 7 8 4 5 6 1 2 3

10 4 4
5 1 6 2 7 3 10 9 8 4

8 5 3
1 6 2 3 4 8 7 5

3 1 3
3 2 1

3 3 1
1 2 3

3 2 2
1 3 2

4 1 5
5 4 3 2 1

4 2 2
3 1 4 2

4 2 3
1 4 3 2



7 4 2
1 5 2 6 3 7 4


5 3 2
1 4 2 5 3

7 4 2
1 5 2 6 3 7 4

7 4 3
1 2 5 3 7 6 4

7 4 4
1 2 3 7 6 5 4

7 5 1
1 2 3 6 4 7 5

5 2 3
3 1 5 4 2

5 1 4
5 4 3 2 1

*/