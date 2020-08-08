import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "j", int, "o", int, "i");

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);

    int[P] ps = [P(0, 0, 0): 0];
    int j, o, i, r;
    foreach (n; 0..N) {
        switch (S[n]) {
            case 'J': ++j; break;
            case 'O': ++o; break;
            case 'I': ++i; break;
            default:
        }

        auto m = min(j, o, i);
        auto p = P(j-m, o-m, i-m);
        if (p in ps) {
            r = max(r, m - ps[p]);
        } else {
            ps[p] = m;
        }
    }
    writeln(r * 3);
}

/*

JOIIJOJOOI

1111223333
0111122344
0012222233


  JJIOOIJIJOIOJIOJOOIJ
J 12222233444455566667
O 00012222233444556777
I 00111223334445555566

IJIJOIOJIOJOOIJ

*/