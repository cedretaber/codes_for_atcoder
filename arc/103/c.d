import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias N = Tuple!(int, "v", int, "cnt");

N[10^^5+1] A, B;

void main()
{
    auto n = readln.chomp.to!int;
    foreach (i, v; readln.split.to!(int[])) {
        if (i%2) {
            A[v].v = v;
            ++A[v].cnt;
        } else {
            B[v].v = v;
            ++B[v].cnt;
        }
    }
    sort!"a.cnt > b.cnt"(A[]);
    sort!"a.cnt > b.cnt"(B[]);

    if (A[0].v != B[0].v) {
        writeln(n - A[0].cnt - B[0].cnt);
    } else {
        writeln(min(
            n - A[0].cnt - (B[1].v == 0 ? 0 : B[1].cnt),
            n - (A[1].v == 0 ? 0 : A[1].cnt) - B[0].cnt
        ));
    }
}