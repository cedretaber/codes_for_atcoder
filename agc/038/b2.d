import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto ps = readln.split.to!(int[]);

    auto cs = new int[](N);
    foreach (i; 0..N-1) {
        if (ps[i+1] < ps[i]) {
            cs[i+1] -= 1;
            cs[max(0, i-K+2)] += 1;
        }
    }
    foreach (i; 1..N) cs[i] += cs[i-1];

    auto rbt = new RedBlackTree!int(ps[0..K]);
    int r;
    bool not_change;
    if (cs[0] == 0) {
        not_change = true;
    } else {
        r = 1;
    }
    foreach (i; 0..N-K) {
        if (ps[i] != rbt.front || ps[i+K] < rbt.back) {
            if (cs[i+1] == 0) {
                not_change = true;
            } else {
                ++r;
            }
        }
        rbt.removeKey(ps[i]);
        rbt.insert(ps[i+K]);
    }
    writeln(r + (not_change ? 1 : 0));
}