
old_input = "# /
third-party/sounds             http://svn.example.com/repos/sounds
third-party/skins -r148        http://svn.example.com/skinproj
third-party/skins/toolkit -r21 http://svn.example.com/skin-maker
"

input = "
# /
/^/trunk/tools/NTService@42476  ext-tools/NTService
/^/trunk/shared/build@42751  shared/build
/^/trunk/shared/include/cxxtest@42751  shared/include/cxxtest
"


def parse_externals(input)
  externals = []
  # externals should contain an array of 
  # hashes with local_dir, url and rev elements
  input.split("\n").each{ |l|
    # TODO: get rid of empty lines, comments and '# /'
    #l.reject { |x| x =~ %r%^\s*/?\s*#% } # get rid of / 

    rev = nil
    # strip the dash rev
    if ! l.grep(/-r\s*(\d+)\b/i).empty? then
      rev = $~[1] 
      l.sub!($~[0], '')
    end
    # strip the peg revision
    if ! l.grep(/@(\d+)\b/i).empty? then
      rev = $~[1]
      l.sub!($~[0], '')
    end
    
    local_dir = ""
    url = ""
    
    # versioned_externals = l.grep(/-r\d+\b/i)
    #     unless versioned_externals.empty?
    #       print "Error: Found external(s) pegged to fixed revision: '#{versioned_externals.join ', '}' in '#{Dir.getwd}', don't know how to handle this."
    #     end
    # try to extract @\d+ from the first element

    if ! l.grep(%r%^/(\S+)\s+(\S+)%).empty? then
      externals += [ { :dir=> $~[2], :url=> $~[1], :rev=> rev } ]
    end
  }
  
  # ext += [ rev ]
  return externals
end

def resolve_url(url, parent_url, repo)
  # TODO: replace ^ with repo
  url.sub!(/^\^/, repo)
  # TODO: replace .. with parent dir
  # TODO: replace // with (something)
  # TODO: replace / with (something)
  return url
end

result = parse_externals input
result.each_with_index { |el, idx| puts "#{idx}: "; el.each { |k,v| puts "#{k}: #{v}" } }

#result = parse_externals old_input
#result.each_with_index { |el, idx| puts "#{idx}: "; el.each { |k,v| puts "#{k}: #{v}" } }

