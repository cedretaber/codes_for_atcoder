import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(long, "a", long, "b", int, "idx");

AB[10^^5] ABS_A, ABS_B;
bool[10^^5] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        auto ab_ = AB(ab[0], ab[1], i);
        ABS_A[i] = ab_;
        ABS_B[i] = ab_;
    }
    sort!"a.a > b.a"(ABS_A[0..N]);
    sort!"a.b > b.b"(ABS_B[0..N]);
    

    int t;
    long sum_a, sum_b;
    auto absa = ABS_A[0..N];
    auto absb = ABS_B[0..N];
    foreach (_; 0..N) {
        ++t;
        while (MEMO[absa[0].idx]) absa = absa[1..$];
        while (MEMO[absb[0].idx]) absb = absb[1..$];
        auto head_a = absa[0];
        auto head_b = absb[0];
        if (head_a.a > head_b.b || (head_a.a == head_b.b && )) {
            MEMO[head_a.idx] = true;
            if (t % 2 == 1) {
                sum_a += head_a.a;
            } else {
                sum_b += head_a.b;
            }
        } else {
            MEMO[head_b.idx] = true;
            if (t % 2 == 1) {
                sum_a += head_b.a;
            } else {
                sum_b += head_b.b;
            }
        }
    }
    writeln(sum_a - sum_b);
}