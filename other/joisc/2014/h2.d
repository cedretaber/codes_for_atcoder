import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "jo", int, "ji", int, "i");

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);

    int J, O, I;
    auto ps = new P[](N);
    foreach (i; 0..N) {
        switch (S[i]) {
            case 'J': ++J; break;
            case 'O': ++O; break;
            case 'I': ++I; break;
            default:
        }
        ps[i] = P(J - O, J - I, i+1);
    }
    ps ~= P(0, 0, 0);
    sort!"a.jo != b.jo ? a.jo < b.jo : a.ji != b.ji ? a.ji < b.ji : a.i < b.i"(ps);
    int res, last_i;
    foreach (i, p; ps) {
        auto q = ps[last_i];
        if (p.jo == q.jo && p.ji == q.ji) {
            res = max(res, p.i - q.i);
        } else {
            last_i = i.to!int;
        }
    }
    writeln(res);
}

/*

J[t] - J[s-1] = O[t] - O[s-1]
J[t] - O[t] = J[s-1] - O[s-1]

*/