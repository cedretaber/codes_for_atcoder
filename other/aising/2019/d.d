import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[100000] AS, AS2, XS, MAX_AS, MIN_AS;

void main()
{
    auto nq = readln.split.to!(long[]);
    auto N = nq[0];
    auto Q = nq[1];

    foreach (i, a; readln.split.to!(long[])) {
        AS[i] = a;
        AS2[i] = a;
    }
    foreach (i; 0..Q) {
        XS[i] = readln.chomp.to!long;
    }

    sort!"a > b"(AS[0..N]);
    size_t[long] ATOP;
    foreach (i; 0..N) {
        ATOP[AS[i]] = i;
        MAX_AS[i] = AS[i];
        if (i) MAX_AS[i] += MAX_AS[i-1];
    }

    foreach_reverse (i; 0..N) {
        MIN_AS[i] = AS[i];
        if (i < N-2) {
            MIN_AS[i] += MIN_AS[i+2];
        }
    }

    foreach (x; XS[0..Q]) {
        sort!((a, b) {
            auto ad = abs(a - x);
            auto bd = abs(b - x);
            return ad == bd ? a < b : ad < bd;
        })(AS2[0..N]);
    }
}

/*

5 5
3 5 7 11 13
1
4
9
10
13

13 11 7 5 3

3 5 7 11 13
3 5 7 11 13
7 11 5 13 3
11 7 13 5 3
13 11 7 5 3

降順に並べ替えて、 n=1, n=2, ..., n=N とする。
n=1 のカードは必ず高橋くんが取る。

n=2 のカードを青木くんが取った場合、高橋くんは n=3　のカードを取る。
その後、交互に取っていく（青木くんが n=2　のカードを取ったという事は、青木くんも降順に取っていく為）。

一般化する。

n=X のカードを青木くんが取った場合、高橋くんは n=T*2+1 のカードを取る（ただし、 T はターン数）。
(お互いに同じ数だけカードを取っているので、列には T 個分の穴が空いており、降順に取ってきた高橋くんの動きと合わせると次に残っているのは T*2+1 番目）
その後は、交互に取っていく。

n=X のカードを高橋くんが取って、次に青木くんが取りたいカードがそれだった場合は、青木くんが n=T*2+1 のカードを取る。
その後は同じ。

降順の累積和と、昇順の飛び飛びの累積和を持っておけば、最初に高橋くんと青木くんの取るカードが干渉する位置から O(1) で合計が算出できる。
*/