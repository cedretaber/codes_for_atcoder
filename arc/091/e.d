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
    auto x = (N-A)/(B-1);
    auto r = (N-A)%(B-1);
    int[] res;
    int i = N;
    foreach (_b; 0..B-1) {
        auto n = x + (r > 0 ? 1 : 0);
        foreach_reverse (d; 0..n) res ~= i-d;
        i -= n;
        --r;
    }
    foreach_reverse (d; 0..A) res ~= i-d;
    if (rev) res = res.reverse.array;
    writeln(res.to!(string[]).join(" "));
}