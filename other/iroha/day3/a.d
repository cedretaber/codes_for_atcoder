import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto fav = ["a", "aa", "aaa", "aaai", "aaaji", "aabaji", "agabaji", "dagabaji"];
    auto x = readln.split.to!(int[]);
    writeln(x[0] - x[1]);
    writeln(x[2] + x[3]);
    writeln(max(x[5] - x[4] + 1, 0));
    writeln((x[6]+x[7]+x[8])/3+1);
    writeln(fav[x[9]-1]);

    long y;
    foreach (i; 1..59*61) {
        if (i%59 == x[10] && i%61 == x[11]) {
            y = i;
            break;
        }
    }
    y += 59L*61L*(x[12]-1);

    long z;
    foreach (p; [6, 28, 496, 8128]) {
        if (abs(p - y) >= x[13]) {
            z = p;
            break;
        }
    }
    writeln(min(y, z));
    writeln(max(y, z));

    writeln(
        (
            (((((x[14]+x[15]+x[16])%9973) *
            ((x[17]+x[18]+x[19])%9973)%9973) *
            ((x[20]+x[21]+x[22])%9973)%9973) *
            ((x[23]+x[24]+x[25])%9973)%9973)
        ) % 9973
    );
}