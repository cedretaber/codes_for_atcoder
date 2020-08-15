import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

bool is_palindrome(string s)
{
    auto len = s.length;
    foreach (d; 0..len/2) if (s[d] != s[$-d-1]) return false;
    return true;
}

alias P = Tuple!(string, "l", string, "r");

void main()
{
    auto N = readln.chomp.to!int;
    string[] SS;
    long[] CS;
    foreach (_; 0..N) {
        auto sc = readln.split;
        SS ~= sc[0];
        CS ~= sc[1].to!long;
    }
    long[P][P] G;
    void add_path(P p) {
        foreach (i; 0..N) {
            auto c = CS[i];
            string s, t;
            if (p.r == "") {
                s = p.l;
                t = SS[i];
            } else {
                s = SS[i];
                t = p.r;
            }
            auto len = min(s.length, t.length);
            size_t l, r = t.length-1;
            P q;
            foreach (d; 0..len) {
                if (s[l+d] != t[r-d]) goto ng;
            }
            if (s.length > t.length) {
                q.l = s[len..$];
                if (is_palindrome(q.l)) q.l = "";
            } else if (s.length < t.length) {
                q.r = t[0..$-len];
                if (is_palindrome(q.r)) q.r = "";
            }
            if (p in G && q in G[p]) {
                G[p][q] = min(G[p][q], c);
            } else {
                G[p][q] = c;
            }
            ng:
        }
    }
    auto E = P("", "");
    foreach (i; 0..N) {
        auto s = SS[i];
        auto c = CS[i];
        if (is_palindrome(s)) {
            auto p = P(s, "");
            G[p][E] = 0;
        }
        foreach (j; 1..s.length+1) {
            add_path(P(s[$-j..$], ""));
            add_path(P("", s[0..j]));
        }
    }

    alias S = Tuple!(P, "p", long, "c");
    long[P] DP;
    S[] ss;
    foreach (i; 0..N) ss ~= S(P(SS[i], ""), CS[i]);
    auto Q = heapify!"a.c > b.c"(ss);
    while (!Q.empty) {
        auto p = Q.front.p;
        auto c = Q.front.c;
        Q.popFront();
        if (p !in G) continue;
        foreach (q, d; G[p]) if (q !in DP || DP[q] > c + d) {
            DP[q] = c + d;
            Q.insert(S(q, c + d));
        }
    }
    writeln(E in DP ? DP[E] : -1);
}