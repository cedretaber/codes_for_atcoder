import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto len = S.length;
    if (len%2 == 1) {
        writeln("No");
        return;
    }

    foreach (i; 0..len/2) {
        auto c = S[len-i-1];
        switch (S[i]) {
            case 'b':
                if (c != 'd') goto default;
                break;
            case 'd':
                if (c != 'b') goto default;
                break;
            case 'p':
                if (c != 'q') goto default;
                break;
            case 'q':
                if (c != 'p') goto default;
                break;
            default:
                writeln("No");
                return;
        }
    }
    writeln("Yes");
}