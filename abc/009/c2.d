import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto S = readln.chomp.to!(char[]);
    if (K < 2) {
        writeln(S);
        return;
    }
    int[26] ii, jj;
    foreach (c; S) {
        ii[c-'a']++;
        jj[c-'a']++;
    }
    auto T = new char[](N);
    foreach (i; 0..N) {
        ii[S[i]-'a']--;
        foreach (c; 'a'..'z'+1) {
            if (jj[c-'a'] <= 0) continue;
            jj[c-'a']--;
            int k = N-i;
            if (c == S[i]) k--;
            foreach (j; 0..26) k -= min(ii[j], jj[j]);
            if (k <= K) {
                T[i] = c.to!char;
                if (c != S[i]) K--;
                break;
            }
            jj[c-'a']++;
        }
    }
    writeln(T);
}