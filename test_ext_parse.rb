require 'test/unit'

require 'git-ext-parse'


# no need to support old style (1.4) externals
#OLD_INPUT = "# /
#third-party/sounds             http://svn.example.com/repos/sounds
#third-party/skins -r148        http://svn.example.com/skinproj
#third-party/skins/toolkit -r21 http://svn.example.com/skin-maker
#"

INPUT = "
# /
/^/trunk/tools/NTService@42476  ext-tools/NTService
/^/trunk/shared/build@42751  shared/build
/^/trunk/shared/include/cxxtest@42751  shared/include/cxxtest
"

class TestExtParse < Test::Unit::TestCase
     # def setup
     # end

     # def teardown
     # end

     def test_input
       result = parse_externals(INPUT)
       puts result
       assert_equal(3, result.length)
       # TODO: check output!
       assert(false)
     end
end


# TODO: test cases for url resolution

class TestUrlResolution < Test::Unit::TestCase
     def test_caret
       result = resolve_url("^/dirA/dirB", "dummy", "https://example.com/svn")
       assert_equal("https://example.com/svn/dirA/dirB", result)
     end
end
