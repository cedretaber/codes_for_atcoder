import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum s2n = ['S': 0, 'H': 1, 'D': 2, 'C': 3];

void main()
{
    auto S = readln.chomp;
    int[4] cs;
    int i;
    char targ;
    for (;;) {
        switch (S[i+1]) {
            case 'A':
                ++cs[s2n[S[i]]];
                break;
            case 'J': goto case 'A';
            case 'Q': goto case 'A';
            case 'K': goto case 'A';
            default:
                if (i+2 < S.length && S[i+2] == '0') goto case 'A';
        }
        foreach (j, c; cs) if (c == 5) {
            targ = S[i];
            goto fin;
        }
        if (i+2 < S.length && S[i+2] == '0') i += 1;
        i += 2;
    }
    fin:
    char[] res;
    i = 0;
    int cnt;
    for (;;) {
        if (S[i] == targ) {
            switch (S[i+1]) {
                case 'A':
                    ++cnt;
                    if (i+2 < S.length && S[i+2] == '0') {
                        ++i;
                    }
                    break;
                case 'J': goto case 'A';
                case 'Q': goto case 'A';
                case 'K': goto case 'A';
                default:
                    if (i+2 < S.length && S[i+2] == '0') goto case 'A';
                    res ~= S[i..i+2];
            }
        } else {
            res ~= S[i..i+2];
            if (S.length > 2 && S[i+2] == '0') {
                res ~= S[i+2];
                ++i;
            }
        }
        if (cnt == 5) break;
        i += 2;
    }
    writeln(res.empty ? "0" : res);
}