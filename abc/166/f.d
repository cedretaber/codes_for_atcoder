import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nabc = readln.split.to!(long[]);
    auto N = nabc[0];
    auto A = nabc[1];
    auto B = nabc[2];
    auto C = nabc[3];

    string[] ss;
    foreach (_; 0..N) ss ~= readln.chomp;

    string[] rs;
    bool was_same;
    foreach (i, s; ss) {
        switch (s) {
            case "AB":
                if (A == 0 && B == 0) {
                    writeln("No");
                    return;
                }
                was_same = false;
                if (A > B) {
                    --A; ++B;
                    rs ~= "B";
                } else {
                    if (A == B) was_same = true;
                    ++A; --B;
                    rs ~= "A";
                }
                break;
            case "AC":
                if (A == 0 && C == 0) {
                    if (was_same && ss[i-1] == "BC") {
                        B -= 2;
                        C += 2;
                        rs[i-1] = "C";
                    } else {
                        writeln("No");
                        return;
                    }
                }
                was_same = false;
                if (A > C) {
                    --A; ++C;
                    rs ~= "C";
                } else {
                    if (A == C) was_same = true;
                    ++A; --C;
                    rs ~= "A";
                }
                break;
            default:
                if (B == 0 && C == 0) {
                    if (was_same) {
                        if (ss[i-1] == "AB") {
                            A -= 2;
                            B += 2;
                            rs[i-1] = "B";
                        } else if (ss[i-1] == "AC") {
                            A -= 2;
                            C += 2;
                            rs[i-1] = "C";
                        }
                    } else {
                        writeln("No");
                        return;
                    }
                }
                was_same = false;
                if (B > C) {
                    --B; ++C;
                    rs ~= "C";
                } else {
                    if (B == C) was_same = true;
                    ++B; --C;
                    rs ~= "B";
                }
        }
    }
    
    writeln("Yes");
    foreach (r; rs) writeln(r);
}