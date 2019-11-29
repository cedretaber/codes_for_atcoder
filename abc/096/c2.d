import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    wchar[][] PIC;
    PIC.length = H;
    foreach (ref line; PIC) {
        line = readln.chomp.to!(wchar[]);
    }

    foreach (i, line; PIC) {
        foreach (j, p; line) {
            if (p == '#') {
                wchar[] cs = "....".to!(wchar[]);
                if (i > 0) cs[0] = PIC[i-1][j];
                if (i < H-1) cs[1] = PIC[i+1][j];
                if (j > 0) cs[2] = PIC[i][j-1];
                if (j < W-1) cs[3] = PIC[i][j+1];
                if (cs == "....") {
                    writeln("No");
                    return;
                }
            }
        }
    }
    writeln("Yes");
}